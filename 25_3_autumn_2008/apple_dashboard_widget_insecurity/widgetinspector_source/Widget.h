//
//  Widget.h
//  WidgetInspector2
//
//  Created by Christoph Eicke on 22.12.07.
//  Copyright 2007 Christoph Eicke <christoph@geisterstunde.org>. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Widget : NSObject {
	@private
	id plist;
	NSString *filePath;
	NSString *error;
	NSPropertyListFormat format;
	NSString *filePathWithPlist;
	NSString *widgetName;
	BOOL *allowNetworkAccess;
	BOOL *allowSystem;
	BOOL *allowFileAccessOutsideOfWidget;
}

-(id)initWithFilePath:(NSString *)theFilePath;
-(NSString *)filePath;
-(NSString *)filePathWithPlist;
-(NSString *)widgetName;
-(BOOL *)allowNetworkAccess;
-(BOOL *)allowSystem;
-(BOOL *)allowFileAccessOutsideOfWidget;

@end
