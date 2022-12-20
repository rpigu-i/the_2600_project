/*
    FSNodeInfo.m
    Copyright (c) 2001-2007, Apple Inc., all rights reserved.
    Author: Chuck Pisula

    Milestones:
    Initially created 3/1/01
    Speed improvements added on 11/21/05 by Corbin Dunn

    Encapsulates information about a file or directory.
*/

/*
 IMPORTANT:  This Apple software is supplied to you by Apple Inc. ("Apple") in
 consideration of your agreement to the following terms, and your use, installation, 
 modification or redistribution of this Apple software constitutes acceptance of these 
 terms.  If you do not agree with these terms, please do not use, install, modify or 
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and subject to these 
 terms, Apple grants you a personal, non-exclusive license, under Apple’s copyrights in 
 this original Apple software (the "Apple Software"), to use, reproduce, modify and 
 redistribute the Apple Software, with or without modifications, in source and/or binary 
 forms; provided that if you redistribute the Apple Software in its entirety and without 
 modifications, you must retain this notice and the following text and disclaimers in all 
 such redistributions of the Apple Software.  Neither the name, trademarks, service marks 
 or logos of Apple Inc. may be used to endorse or promote products derived from 
 the Apple Software without specific prior written permission from Apple. Except as expressly
 stated in this notice, no other rights or licenses, express or implied, are granted by Apple
 herein, including but not limited to any patent rights that may be infringed by your 
 derivative works or by other works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE MAKES NO WARRANTIES, 
 EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, 
 MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS 
 USE AND OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL OR CONSEQUENTIAL 
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS 
 OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, 
 REPRODUCTION, MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED AND 
 WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE), STRICT LIABILITY OR 
 OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

#import "FSNodeInfo.h"

@implementation FSNodeInfo 

+ (FSNodeInfo *)nodeWithParent:(FSNodeInfo *)parent atRelativePath:(NSString *)path {
    return [[[FSNodeInfo alloc] initWithParent:parent atRelativePath:path] autorelease];
}

- (id)initWithParent:(FSNodeInfo *)parent atRelativePath:(NSString *)path {    
    if (self = [super init]) {
        parentNode = parent;
        relativePath = [path retain];
        
        // Calculate the absolute path based on our parent
        if (parentNode != nil) {
            NSString *parentAbsPath = [parentNode absolutePath];
            if ([parentAbsPath isEqualToString: @"/"]) parentAbsPath = @"";
            absolutePath = [[NSString alloc] initWithFormat:@"%@/%@", parentAbsPath, relativePath];
        } else {
            absolutePath = [relativePath retain];
        }
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        // Figure out if we are a link or not. Doing it once helps a lot with performance
        NSDictionary *fileAttributes = [fileManager fileAttributesAtPath:absolutePath traverseLink:NO];
        isLink = [[fileAttributes fileType] isEqualToString:NSFileTypeSymbolicLink];

        // Find out if we are a directory or not.
        isDirectory = NO;
        BOOL exists = [fileManager fileExistsAtPath:absolutePath isDirectory:&isDirectory];
        isDirectory = (exists && isDirectory);
        
        // Find out if we can read that node
        isReadable = [fileManager isReadableFileAtPath:absolutePath];
    }
    
    return self;
}

- (void)dealloc {
    // parentNode is not released since we never retained it. It is a weak reference.
    [relativePath release];
    [absolutePath release];
    [subNodes release];
    [super dealloc];
}

- (void)invalidateChildren {
    [subNodes release];
    subNodes = nil;
}

- (NSArray *)subNodes {
    if (subNodes == nil) {
        // We will cache the subnodes to help improve speed
        NSArray *contentsAtPath = [[NSFileManager defaultManager] directoryContentsAtPath:[self absolutePath]];
        NSInteger subCount = [contentsAtPath count];
        subNodes = [[NSMutableArray alloc] initWithCapacity:subCount];
        for (NSString *subNodePath in contentsAtPath) {
            FSNodeInfo *node = [FSNodeInfo nodeWithParent:self atRelativePath:subNodePath];
            if ([node isVisible]) {
                [subNodes addObject:node];
            }
        }
    }
    return subNodes;
}

- (BOOL)isLink {
    return isLink;
}

- (BOOL)isDirectory {
    return isDirectory;
}

- (BOOL)isReadable {
    return isReadable;
}

- (BOOL)isVisible {
    // Make this as sophisticated for example to hide more files you don't think the user should see!
    NSString *lastPathComponent = [self lastPathComponent];
    return ([lastPathComponent length] ? ([lastPathComponent characterAtIndex:0]!='.') : NO);
}

- (NSString *)fsType {
    if ([self isDirectory]) return @"Directory";
    else return @"Non-Directory";
}

- (NSString *)lastPathComponent {
    return [relativePath lastPathComponent];
}

- (NSString *)absolutePath {
    return absolutePath;
}

- (NSImage *)iconImageOfSize:(NSSize)size {
    NSString *path = [self absolutePath];
    NSImage *nodeImage = nil;
    
    nodeImage = [[NSWorkspace sharedWorkspace] iconForFile:path];
    if (!nodeImage) {
        // No icon for actual file, try the extension.
        nodeImage = [[NSWorkspace sharedWorkspace] iconForFileType:[path pathExtension]];
    }
    [nodeImage setSize:size];
    
    if ([self isLink]) {
        NSImage *arrowImage = [NSImage imageNamed:@"FSIconImage-LinkArrow"];
        NSImage *nodeImageWithArrow = [[[NSImage alloc] initWithSize: size] autorelease];
        
	[arrowImage setScalesWhenResized:YES];
	[arrowImage setSize:size];
	
        [nodeImageWithArrow lockFocus];
	[nodeImage compositeToPoint:NSZeroPoint operation:NSCompositeCopy];
        [arrowImage compositeToPoint:NSZeroPoint operation:NSCompositeSourceOver];
        [nodeImageWithArrow unlockFocus];
	
	nodeImage = nodeImageWithArrow;
    }
    
    if (nodeImage == nil) {
        nodeImage = [NSImage imageNamed:@"FSIconImage-Default"];
    }
    
    return nodeImage;
}

@end
