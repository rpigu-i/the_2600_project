//
//  Widget.m
//  WidgetInspector2
//
//  Created by Christoph Eicke on 22.12.07.
//  Copyright 2007 Christoph Eicke <christoph@geisterstunde.org>. All rights reserved.
//

#import "Widget.h"


@implementation Widget

-(id)initWithFilePath:(NSString *)theFilePath {
	if ( self = [super init] ) {
		filePath = [theFilePath copy];
	}
		
	// build the filePathWithPlist file path
	NSMutableString *str = [NSMutableString stringWithString:filePath];
	[str appendString:@"/Info.plist"];
	filePathWithPlist = str;
	
	NSDictionary *glossary;	
	// set the default parameter to 'false'
	allowNetworkAccess = false;
	allowSystem = false;
	allowFileAccessOutsideOfWidget = false;
		
	glossary = [NSDictionary dictionaryWithContentsOfFile:filePathWithPlist];
	
	if(glossary == nil)
	{
		NSLog(@"Plist not valid");
	} else {
						
		@try {
			widgetName = [glossary objectForKey: @"CFBundleName"];
			allowFileAccessOutsideOfWidget = [[glossary objectForKey: @"AllowFileAccessOutsideOfWidget"] boolValue];
			allowSystem = [[glossary objectForKey: @"AllowSystem"] boolValue];
			allowNetworkAccess = [[glossary objectForKey: @"AllowNetworkAccess"] boolValue];
		} 
			
		@catch(NSException *e) {
			return -1;
		}
	}
	
	return self;
}

-(void)dealloc {
	[filePath release];
	[super dealloc];
}

-(NSString *)filePath {
	return filePath;
}

-(NSString *)filePathWithPlist {
	return filePathWithPlist;
}

-(NSString *)widgetName {
	return widgetName;
}

-(BOOL *)allowNetworkAccess {
	return allowNetworkAccess;
}

-(BOOL *)allowSystem {
	return allowSystem;
}

-(BOOL *)allowFileAccessOutsideOfWidget {
	return allowFileAccessOutsideOfWidget;
}

@end
