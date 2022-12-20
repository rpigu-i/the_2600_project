#import "WidgetInspector.h"
#import "Widget.h"
#import "FSNodeInfo.h"
#import "FSBrowserCell.h"

/**
 
 Next Steps:
 ===========
 
 - Populate Drawer List
 - Make Items in Drawer List respond to double click action
 
 
 */

@implementation WidgetInspector

- (void)awakeFromNib {
	[plistBrowser setCellClass: [FSBrowserCell class]];
	
	[plistBrowser setTarget:self];
	[plistBrowser setAction:@selector(browserSingleClick:)];
	[plistBrowser setDoubleAction:@selector(browserDoubleClick:)];
	[plistBrowser setMaxVisibleColumns:3];
	[plistBrowser setMinColumnWidth:NSWidth([plistBrowser bounds])/(CGFloat)3];
}

- (void)dealloc {
    [rootNodeInfo release];
    [super dealloc];
}


- (IBAction)openWidget:(id)sender {
	
	NSOpenPanel *openPanel = [NSOpenPanel openPanel];
	NSArray *fileTypes = [NSArray arrayWithObject:@"wdgt"];
	NSString *widgetFilePath;
	
	[openPanel setAllowsMultipleSelection:NO];
	[openPanel setCanChooseDirectories:NO];
	[openPanel setCanChooseFiles:YES];
	[openPanel setResolvesAliases:YES];
	[openPanel setTitle:@"Select a widget to open"];
	
	if([openPanel runModalForTypes:fileTypes] == NSOKButton) {		
		widgetFilePath = [openPanel filename];
		
		[self checkWidgetParameters: widgetFilePath];
		
	}	
}

-(void)checkWidgetParameters:(NSString *)widgetPath {
	
	NSString *widgetFilePath = [widgetPath copy];
	
	Widget *theWidget = [[[Widget alloc] initWithFilePath:widgetFilePath] autorelease];
	int threatLevelValue = 1;
	
	NSLog([theWidget filePathWithPlist]);
	
	// set the widget name
	[widgetName setStringValue:[theWidget widgetName]];
	
	// check the different access methods
	if([theWidget allowNetworkAccess]) {
		[networkAccess setState:1];
		threatLevelValue++;
	} else {
		[networkAccess setState:0];
	}
	
	if([theWidget allowSystem]) {
		[systemAccess setState:1];
		threatLevelValue++;
	} else {
		[systemAccess setState:0];
	}
	
	if([theWidget allowFileAccessOutsideOfWidget]) {
		[fileAccess setState:1];
		threatLevelValue++;
	} else {
		[fileAccess setState:0];
	}
	
	// set the image
	NSString *widgetIconPath = [widgetFilePath stringByAppendingString:@"/Default.png"];
	NSImage *widgetIcon = [[[NSImage alloc] initWithContentsOfFile:widgetIconPath] autorelease];
	[widgetImage setImage:widgetIcon];
	
	// set the threat level of this widget
	[threatLevel setIntValue:threatLevelValue];
	
	// open the plist in the browser
	[plistBrowser setHidden:NO];
	[plistBrowser setPath:[widgetFilePath stringByAppendingString:@"/"]];
}

- (IBAction)reloadData:(id)sender {
    [plistBrowser loadColumnZero];
}

#pragma mark ** Browser Delegate Methods **

- (FSNodeInfo *)parentNodeInfoForColumn:(NSInteger)column {
	NSLog(@"Bla");
    FSNodeInfo *result;
    if (column == 0) {
        if (rootNodeInfo == nil) {
            rootNodeInfo = [[FSNodeInfo alloc] initWithParent:nil atRelativePath:@"/"];
        }
        result = rootNodeInfo;
    } else {
        // Find the selected item leading up to this column and grab its FSNodeInfo stored in that cell
        FSBrowserCell *selectedCell = [plistBrowser selectedCellInColumn:column-1];
        result = [selectedCell nodeInfo];
    }
    return result;
}

// Use lazy initialization, since we don't want to touch the file system too much.
- (NSInteger)browser:(NSBrowser *)sender numberOfRowsInColumn:(NSInteger)column {
    FSNodeInfo *parentNodeInfo = [self parentNodeInfoForColumn:column];
    return [[parentNodeInfo subNodes] count];
}

- (void)browser:(NSBrowser *)sender willDisplayCell:(FSBrowserCell *)cell atRow:(NSInteger)row column:(NSInteger)column {
    // Find our parent FSNodeInfo and access the child at this particular row
    FSNodeInfo *parentNodeInfo = [self parentNodeInfoForColumn:column];
    FSNodeInfo *currentNodeInfo = [[parentNodeInfo subNodes] objectAtIndex:row];
    [cell setNodeInfo:currentNodeInfo];
    [cell loadCellContents];
}

#pragma mark ** Browser Target / Action Methods **

- (IBAction)browserSingleClick:(id)browser {
    // In order to improve performance, we only want to update the preview image if the user pauses for at least a moment on a select node. This allows one to scroll through the nodes at a more acceptable pace. First, we cancel the previous request so we don't get a whole bunch of them queued up.
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(updateCurrentPreviewImage:) object:browser];
    [self performSelector:@selector(updateCurrentPreviewImage:) withObject:browser afterDelay:0.3];    
}

- (IBAction)browserDoubleClick:(id)browser {
    // Open the file and display it information by calling the single click routine.
    NSString *nodePath = [browser path];
    [self browserSingleClick: browser];
    [[NSWorkspace sharedWorkspace] openFile: nodePath];
}

@end
