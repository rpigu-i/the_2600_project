#import <Cocoa/Cocoa.h>
#import "Widget.h"
@class FSNodeInfo;

@interface WidgetInspector : NSWindow /* Specify a superclass (eg: NSObject or NSView) */ {
    IBOutlet NSButton *fileAccess;
    IBOutlet NSButton *networkAccess;
	IBOutlet NSToolbarItem *openWidget;
	IBOutlet NSToolbarItem *scanForWidgets;
    IBOutlet NSButton *systemAccess;
    IBOutlet NSImageView *widgetImage;
    IBOutlet NSTextField *widgetName;
	IBOutlet NSLevelIndicator *threatLevel;
	IBOutlet NSBrowser *plistBrowser;
	
	IBOutlet NSImageView  *nodeIconWell;  // Image well showing the selected items icon.
    IBOutlet NSTextField  *nodeInspector; // Text field showing the selected items attribu
	FSNodeInfo *rootNodeInfo;
}
- (IBAction)openWidget:(id)sender;
- (void)checkWidgetParameters:(NSString *)widgetPath;

// Force a reload of column zero and thus, all the data.
- (IBAction)reloadData:(id)sender;

// Methods sent by the browser to us from theBrowser.
- (IBAction)browserSingleClick:(id)sender;
- (IBAction)browserDoubleClick:(id)sender;

@end
