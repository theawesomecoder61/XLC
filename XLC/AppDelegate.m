//
//  AppDelegate.m
//  XLC
//
//  Created by Andrew Mellen on 8/19/16.
//  Copyright © 2016 theawesomecoder61. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate () {
    NSString *path;
    NSURL *pathURL;
    NSInteger lineCt;
    NSInteger charCt;
    NSMutableArray *reviewedFiles;
    NSMutableArray *lineNums;
    NSMutableArray *charCount;
}

@property (weak) IBOutlet NSWindow *window;

@property (weak) IBOutlet NSTextField *pathTF;
@property (weak) IBOutlet NSButton *mCB;
@property (weak) IBOutlet NSButton *hCB;
@property (weak) IBOutlet NSButton *cCB;
@property (weak) IBOutlet NSButton *cppCB;
@property (weak) IBOutlet NSButton *txtCB;
@property (weak) IBOutlet NSButton *xibCB;
@property (weak) IBOutlet NSButton *mdCB;
@property (weak) IBOutlet NSButton *htmlCB;
@property (weak) IBOutlet NSButton *cssCB;
@property (weak) IBOutlet NSButton *jsCB;
@property (weak) IBOutlet NSButton *xmlCB;
@property (weak) IBOutlet NSButton *plistCB;
@property (weak) IBOutlet NSButton *emptyLinesCB;
@property (weak) IBOutlet NSButton *fwFilesCB;
@property (weak) IBOutlet NSButton *countBtn;
@property (weak) IBOutlet NSTextField *lineTotalLabel;
@property (weak) IBOutlet NSTextField *charTotalLabel;
@property (weak) IBOutlet NSTableView *resultTV;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    lineCt = 0;
    charCt = 0;
    [self.countBtn setEnabled:NO];
    [self.resultTV setDelegate:self];
    [self.resultTV setDataSource:self];
    reviewedFiles = [NSMutableArray array];
    lineNums = [NSMutableArray array];
    charCount = [NSMutableArray array];
    [self.resultTV reloadData];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

- (IBAction)setPath:(id)sender {
    NSOpenPanel *op = [NSOpenPanel openPanel];
    [op setTitle:@"Select an .xcodeproj"];
    [op setCanChooseFiles:YES];
    [op setCanChooseDirectories:NO];
    [op setCanCreateDirectories:NO];
    [op setAllowedFileTypes:@[@"xcodeproj"]];
    if([op runModal] == NSModalResponseOK) {
        [self.countBtn setEnabled:YES];
        path = [[[[op URL] absoluteString] stringByReplacingOccurrencesOfString:@"file://" withString:@""] stringByDeletingLastPathComponent];
        NSLog(@"%@", path);
        pathURL = [op URL];
        [self.pathTF setStringValue:path];
    }
}

- (IBAction)beginCounting:(id)sender {
    lineCt = 0;
    charCt = 0;
    reviewedFiles = [NSMutableArray array];
    lineNums = [NSMutableArray array];
    charCount = [NSMutableArray array];
    NSString *sourcePath = [path stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:sourcePath];
    NSString *fn;
    
    while((fn = [dirEnum nextObject])) {
        if([fn containsString:@".framework"]) {
            if([self.fwFilesCB state]) {
                if([[[fn pathExtension] lowercaseString] isEqualTo:@"m"] && [self.mCB state]) {
                    [self numOfLinesInFile:[path stringByAppendingPathComponent:fn] withName:fn];
                }
                if([[[fn pathExtension] lowercaseString] isEqualTo:@"h"] && [self.hCB state]) {
                    [self numOfLinesInFile:[path stringByAppendingPathComponent:fn] withName:fn];
                }
                if([[[fn pathExtension] lowercaseString] isEqualTo:@"c"] && [self.cCB state]) {
                    [self numOfLinesInFile:[path stringByAppendingPathComponent:fn] withName:fn];
                }
                if([[[fn pathExtension] lowercaseString] isEqualTo:@"cpp"] && [self.cppCB state]) {
                    [self numOfLinesInFile:[path stringByAppendingPathComponent:fn] withName:fn];
                }
                if([[[fn pathExtension] lowercaseString] isEqualTo:@"txt"] && [self.txtCB state]) {
                    [self numOfLinesInFile:[path stringByAppendingPathComponent:fn] withName:fn];
                }
                if([[[fn pathExtension] lowercaseString] isEqualTo:@"xib"] && [self.xibCB state]) {
                    [self numOfLinesInFile:[path stringByAppendingPathComponent:fn] withName:fn];
                }
                if([[[fn pathExtension] lowercaseString] isEqualTo:@"md"] && [self.mdCB state]) {
                    [self numOfLinesInFile:[path stringByAppendingPathComponent:fn] withName:fn];
                }
                if([[[fn pathExtension] lowercaseString] isEqualTo:@"html"] && [self.htmlCB state]) {
                    [self numOfLinesInFile:[path stringByAppendingPathComponent:fn] withName:fn];
                }
                if([[[fn pathExtension] lowercaseString] isEqualTo:@"css"] && [self.cssCB state]) {
                    [self numOfLinesInFile:[path stringByAppendingPathComponent:fn] withName:fn];
                }
                if([[[fn pathExtension] lowercaseString] isEqualTo:@"js"] && [self.jsCB state]) {
                    [self numOfLinesInFile:[path stringByAppendingPathComponent:fn] withName:fn];
                }
                if([[[fn pathExtension] lowercaseString] isEqualTo:@"xml"] && [self.xmlCB state]) {
                    [self numOfLinesInFile:[path stringByAppendingPathComponent:fn] withName:fn];
                }
                if([[[fn pathExtension] lowercaseString] isEqualTo:@"plist"] && [self.plistCB state]) {
                    [self numOfLinesInFile:[path stringByAppendingPathComponent:fn] withName:fn];
                }
            }
        } else {
            if([[[fn pathExtension] lowercaseString] isEqualTo:@"m"] && [self.mCB state]) {
                [self numOfLinesInFile:[path stringByAppendingPathComponent:fn] withName:fn];
            }
            if([[[fn pathExtension] lowercaseString] isEqualTo:@"h"] && [self.hCB state]) {
                [self numOfLinesInFile:[path stringByAppendingPathComponent:fn] withName:fn];
            }
            if([[[fn pathExtension] lowercaseString] isEqualTo:@"c"] && [self.cCB state]) {
                [self numOfLinesInFile:[path stringByAppendingPathComponent:fn] withName:fn];
            }
            if([[[fn pathExtension] lowercaseString] isEqualTo:@"cpp"] && [self.cppCB state]) {
                [self numOfLinesInFile:[path stringByAppendingPathComponent:fn] withName:fn];
            }
            if([[[fn pathExtension] lowercaseString] isEqualTo:@"txt"] && [self.txtCB state]) {
                [self numOfLinesInFile:[path stringByAppendingPathComponent:fn] withName:fn];
            }
            if([[[fn pathExtension] lowercaseString] isEqualTo:@"xib"] && [self.xibCB state]) {
                [self numOfLinesInFile:[path stringByAppendingPathComponent:fn] withName:fn];
            }
            if([[[fn pathExtension] lowercaseString] isEqualTo:@"md"] && [self.mdCB state]) {
                [self numOfLinesInFile:[path stringByAppendingPathComponent:fn] withName:fn];
            }
            if([[[fn pathExtension] lowercaseString] isEqualTo:@"html"] && [self.htmlCB state]) {
                [self numOfLinesInFile:[path stringByAppendingPathComponent:fn] withName:fn];
            }
            if([[[fn pathExtension] lowercaseString] isEqualTo:@"css"] && [self.cssCB state]) {
                [self numOfLinesInFile:[path stringByAppendingPathComponent:fn] withName:fn];
            }
            if([[[fn pathExtension] lowercaseString] isEqualTo:@"js"] && [self.jsCB state]) {
                [self numOfLinesInFile:[path stringByAppendingPathComponent:fn] withName:fn];
            }
            if([[[fn pathExtension] lowercaseString] isEqualTo:@"xml"] && [self.xmlCB state]) {
                [self numOfLinesInFile:[path stringByAppendingPathComponent:fn] withName:fn];
            }
            if([[[fn pathExtension] lowercaseString] isEqualTo:@"plist"] && [self.plistCB state]) {
                [self numOfLinesInFile:[path stringByAppendingPathComponent:fn] withName:fn];
            }
        }
    }
}

- (void)numOfLinesInFile:(NSString *)f withName:(NSString *)fn {
    NSString *c = [NSString stringWithContentsOfFile:[f stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] encoding:NSUTF8StringEncoding error:nil];
    NSInteger total = [[c componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] count];
    NSArray *lines = [c componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    for(NSString *l in lines) {
        if([self.emptyLinesCB state]) {
            if([l isEqualTo:@""] || [l isEqualTo:nil]) {
                total++;
            }
        }
    }
    
    lineCt += total;
    charCt += [c length];
    
    [reviewedFiles addObject:fn];
    [lineNums addObject:[NSString stringWithFormat:@"%ld", (long)total]];
    [charCount addObject:[NSString stringWithFormat:@"%lu", (unsigned long)[c length]]];
    
    [self.resultTV reloadData];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *formatted = [formatter stringFromNumber:[NSNumber numberWithInteger:lineCt]];
    [self.lineTotalLabel setStringValue:[NSString stringWithFormat:@"%@ lines", formatted]];
    
    formatted = [formatter stringFromNumber:[NSNumber numberWithInteger:charCt]];
    [self.charTotalLabel setStringValue:[NSString stringWithFormat:@"%@ characters", formatted]];
}

//
// NSTableStuff
//
- (NSInteger)numberOfSectionsInTableView:(NSTableView *)tableView {
    return 1;
}
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [reviewedFiles count];
}
- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSString *r = @"";
    if([[tableColumn identifier] isEqualTo:@"path"]) {
        r = [reviewedFiles objectAtIndex:row];
    } else if([[tableColumn identifier] isEqualTo:@"line"]) {
        r = [lineNums objectAtIndex:row];
    } else if([[tableColumn identifier] isEqualTo:@"ch"]) {
        r = [charCount objectAtIndex:row];
    }
    return r;
 }

@end