//
//  FSNodeInfo.h
//
//  Copyright (c) 2001-2007, Apple Inc. All rights reserved.
//
//  FSNodeInfo encapsulates information about a file or directory.
//  This implementation is not necessarily the best way to do something like this,
//  it is simply a wrapper to make the rest of the browser code easy to follow.

#import <Cocoa/Cocoa.h>

@interface FSNodeInfo : NSObject {
@private
    NSString  *relativePath; // Path relative to the parent.
    FSNodeInfo *parentNode; // Containing directory, not retained to avoid retain/release cycles.
    NSString *absolutePath;
    BOOL isLink;
    BOOL isDirectory;
    BOOL isReadable;
    NSMutableArray *subNodes;
}

+ (FSNodeInfo *)nodeWithParent:(FSNodeInfo*)parent atRelativePath:(NSString *)path;

- (id)initWithParent:(FSNodeInfo*)parent atRelativePath:(NSString*)path;

- (void)dealloc;

- (NSArray *)subNodes;

- (void)invalidateChildren;

- (NSString *)fsType;
- (NSString *)absolutePath;
- (NSString *)lastPathComponent;

- (BOOL)isLink;
- (BOOL)isDirectory;

- (BOOL)isReadable;
- (BOOL)isVisible;

- (NSImage*)iconImageOfSize:(NSSize)size; 

@end
