//
//  FSBrowserCell.h
//
//  Copyright (c) 2001-2007, Apple Inc. All rights reserved.
//
//  FSBrowserCell knows how to display file system info obtained from an FSNodeInfo object.

#import <Cocoa/Cocoa.h>

@interface FSBrowserCell : NSBrowserCell { 
@private
    NSImage *iconImage;
    FSNodeInfo *nodeInfo;
    BOOL drawsBackground;
}

- (void)setNodeInfo:(FSNodeInfo *)value;
- (FSNodeInfo *)nodeInfo;

- (void)setIconImage:(NSImage *)image;
- (NSImage *)iconImage;

- (void)loadCellContents;

@end