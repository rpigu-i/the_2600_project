/*
    FSBrowserCell.m
    Copyright (c) 2001-2007, Apple Inc., all rights reserved.
    Author: Chuck Pisula

    Milestones:
    Initially created 3/1/01
    Speed improvements and caching added on 11/21/05 by Corbin Dunn
    Drawing updates for drag and drop support on 06/22/07 by Corbin Dunn

    A browser cell that knows how to display file system info obtained from an FSNodeInfo object.
*/

/*
 IMPORTANT:  This Apple software is supplied to you by Apple Inc. ("Apple") in
 consideration of your agreement to the following terms, and your use, installation, 
 modification or redistribution of this Apple software constitutes acceptance of these 
 terms.  If you do not agree with these terms, please do not use, install, modify or 
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and subject to these 
 terms, Apple grants you a personal, non-exclusive license, under AppleÕs copyrights in 
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
#import "FSBrowserCell.h"

#define ICON_INSET_VERT		2.0	/* The size of empty space between the icon end the top/bottom of the cell */ 
#define ICON_SIZE 		16.0	/* Our Icons are ICON_SIZE x ICON_SIZE */
#define ICON_INSET_HORIZ	4.0	/* Distance to inset the icon from the left edge. */
#define ICON_TEXT_SPACING	2.0	/* Distance between the end of the icon and the text part */

@interface FSBrowserCell(PrivateUtilities)
- (NSDictionary *)fsStringAttributes;
@end

@implementation FSBrowserCell

+ (NSImage *)branchImage {
    // Override the default branch image (we don't want the arrow).
    return nil;
}

+ (NSImage *)highlightedBranchImage {
    // Override the default branch image (we don't want the arrow).
    return nil;
}

- (id)init {
    if (self = [super init]) {
        drawsBackground = YES;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    FSBrowserCell *result = [super copyWithZone:zone];
    result->nodeInfo = nil;
    result->iconImage = nil;
    // We need to properly retain each of the items below
    [result setNodeInfo:nodeInfo];
    [result setIconImage:iconImage];
    return result;
}

- (void)dealloc {
    [iconImage release];
    [nodeInfo release];
    [super dealloc];
}

- (void)setNodeInfo:(FSNodeInfo *)value {
    if (nodeInfo != value) {
        [nodeInfo release];
        nodeInfo = [value retain];
    }
}

- (FSNodeInfo *)nodeInfo {
    return nodeInfo;
}

- (void)loadCellContents {
    // Given a particular FSNodeInfo object set up our display properties.
    NSString *stringValue = [nodeInfo lastPathComponent];
    
    // Set the text part.  FSNode will format the string (underline, bold, etc...) based on various properties of the file.
    NSAttributedString *attrStringValue = [[NSAttributedString alloc] initWithString:stringValue attributes:[self fsStringAttributes]];
    [self setAttributedStringValue:attrStringValue];
    [attrStringValue release];
    
    // Set the image part.  FSNodeInfo knows how to look up the proper icon to use for a give file/directory.
    [self setIconImage:[nodeInfo iconImageOfSize:NSMakeSize(ICON_SIZE, ICON_SIZE)]];
    
    // If we don't have access to the file, make sure the user can't select it!
    [self setEnabled:[nodeInfo isReadable]];

    // Make sure the cell knows if it has children or not.
    [self setLeaf:![nodeInfo isDirectory]];
}

- (void)setIconImage:(NSImage *)image {
    if (image != iconImage) {
        [iconImage release];
        iconImage = [image retain];
    }
}

- (NSImage *)iconImage {
    return iconImage;
}

- (NSSize)cellSizeForBounds:(NSRect)aRect {
    // Make our cells a bit higher than normal to give some additional space for the icon to fit.
    NSSize theSize = [super cellSizeForBounds:aRect];
    NSSize iconSize = iconImage ? [iconImage size] : NSZeroSize;
    theSize.width += iconSize.width + ICON_INSET_HORIZ + ICON_TEXT_SPACING;
    theSize.height = ICON_SIZE + ICON_INSET_VERT * 2.0;
    return theSize;
}

// When doing a drag and drop, NSBrowser will call set drawsBackground to NO when creating the drag image.
- (BOOL)drawsBackground {
    return drawsBackground;
}

- (void)setDrawsBackground:(BOOL)value {
    drawsBackground = value;
}

- (void)drawInteriorWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {    
    if (iconImage != nil) {
        NSSize imageSize = [iconImage size];
        NSRect imageFrame, highlightRect, textFrame;
	
	// Divide the cell into 2 parts, the image part (on the left) and the text part.
	NSDivideRect(cellFrame, &imageFrame, &textFrame, ICON_INSET_HORIZ + ICON_TEXT_SPACING + imageSize.width, NSMinXEdge);
        imageFrame.origin.x += ICON_INSET_HORIZ;
        imageFrame.size = imageSize;

	// Adjust the image frame top account for the fact that we may or may not be in a flipped control view, since when compositing the online documentation states: "The image will have the orientation of the base coordinate system, regardless of the destination coordinates".
        if ([controlView isFlipped]) {
            imageFrame.origin.y += ceil((textFrame.size.height + imageFrame.size.height) / 2);
        } else {
            imageFrame.origin.y += ceil((textFrame.size.height - imageFrame.size.height) / 2);
        }

        // We don't draw the background when creating the drag and drop image
        if (drawsBackground) {
            // If we are highlighted, or we are selected (ie: the state isn't 0), then draw the highlight color
            if ([self isHighlighted] || [self state] != 0) {
                // The return value from highlightColorInView will return the appropriate one for you. 
                [[self highlightColorInView:controlView] set];
                // Draw the highlight, but only the portion that won't be caught by the call to [super drawInteriorWithFrame:...] below.  
                highlightRect = NSMakeRect(NSMinX(cellFrame), NSMinY(cellFrame), NSWidth(cellFrame) - NSWidth(textFrame), NSHeight(cellFrame));
                NSRectFill(highlightRect);
            }
        }
	
        [iconImage compositeToPoint:imageFrame.origin operation:NSCompositeSourceOver fraction:1.0];
    
	// Have NSBrowserCell kindly draw the text part, since it knows how to do that for us, no need to re-invent what it knows how to do.
	[super drawInteriorWithFrame:textFrame inView:controlView];
    } else {
	// At least draw something if we couldn't find an icon. You may want to do something more intelligent.
    	[super drawInteriorWithFrame:cellFrame inView:controlView];
    }
}

// Expansion tool tip support

- (NSRect)expansionFrameWithFrame:(NSRect)cellFrame inView:(NSView *)view {
    // We could access our reccomended cell size with [self cellSize] and see if it fits in cellFrame, but NSBrowserCell already does this for us!
    NSRect expansionFrame = [super expansionFrameWithFrame:cellFrame inView:view];
    // If we do need an expansion frame, the rect will be non-empty. We need to move it over, and shrink it, since we won't be drawing the icon in it
    if (!NSIsEmptyRect(expansionFrame)) {
        NSSize iconSize = iconImage ? [iconImage size] : NSZeroSize;
        expansionFrame.origin.x = expansionFrame.origin.x + iconSize.width + ICON_INSET_HORIZ + ICON_TEXT_SPACING;
        expansionFrame.size.width = expansionFrame.size.width - (iconSize.width + ICON_TEXT_SPACING + ICON_INSET_HORIZ / 2.0);
    }
    return expansionFrame;
}

- (void)drawWithExpansionFrame:(NSRect)cellFrame inView:(NSView *)view {
    // We want to ignore the image that is to be custom drawn, and just let the superclass handle the drawing. This will correctly draw just the text, but nothing else
    [super drawInteriorWithFrame:cellFrame inView:view];
}

- (NSDictionary *)fsStringAttributes {
    // Cache the two common attribute cases to help improve speed. This will be called a lot, and helps improve performance.
    static NSDictionary *standardAttributes = nil;
    static NSDictionary *underlinedAttributes = nil;
    
    if (standardAttributes == nil) {
        NSMutableParagraphStyle *ps = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        [ps setLineBreakMode:NSLineBreakByTruncatingMiddle];
        standardAttributes = [[NSDictionary alloc] initWithObjectsAndKeys:
            [NSFont systemFontOfSize:[NSFont systemFontSize]], NSFontAttributeName, 
            ps, NSParagraphStyleAttributeName,
            nil];
        underlinedAttributes = [[NSDictionary alloc] initWithObjectsAndKeys:
            [NSFont systemFontOfSize:[NSFont systemFontSize]], NSFontAttributeName,
            [NSNumber numberWithInteger:NSSingleUnderlineStyle], NSUnderlineStyleAttributeName,
            ps, NSParagraphStyleAttributeName,
            nil];
        [ps release];
    }
    
    // If the node is a link, we will return the underlined attributes
    if ([nodeInfo isLink]) {
        return underlinedAttributes;
    } else {
        return standardAttributes;
    }
}

@end

