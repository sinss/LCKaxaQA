//
//  GlobalFunctions.m
//  ClockReminder
//
//  Created by 張星星 on 11/12/16.
//  Copyright (c) 2011年 星星. All rights reserved.
//

#import "GlobalFunctions.h"
static GlobalFunctions *_instance;
@implementation GlobalFunctions

#pragma mark - UserDefaults

+ (GlobalFunctions*)shareInstance
{
    @synchronized(self)
    {
        if (_instance == nil)
        {
            //iOS4 compatibility check
            Class notificationClass = NSClassFromString(@"GlobalFunctions");
            if (notificationClass == nil)
            {
                return _instance = nil;
            }
            else
            {
                _instance = [[super allocWithZone:NULL] init];
            }
        }
    }
    return _instance;
}

- (NSString*)getDocumentFullPath:(NSString*)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);  
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fullName = [documentsDirectory stringByAppendingPathComponent:fileName];
    return fullName;
}
- (NSString*)getTempDirectoryFullPath:(NSString*)fileName
{
    NSString *tempDirectory = NSTemporaryDirectory();
    NSString *fullPath = [tempDirectory stringByAppendingPathComponent:fileName];
    return fullPath;
}
- (void)saveAppInfoWithKey:(NSString*)key andValue:(NSString*)value
{
    NSString *appInfoPath = [self getDocumentFullPath:@"appInfo.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:appInfoPath])
    {
        //NSString *appInfoBundle = [[NSBundle mainBundle] pathForResource:@"appInfo" ofType:@"plist"];
        //if (![[NSFileManager defaultManager] copyItemAtPath:appInfoBundle toPath:appInfoPath error:nil])
            //NSLog(@"Copy appInfo faild");
        NSDictionary *dictionAry = [[NSDictionary alloc] initWithObjectsAndKeys:@"Reachable",@"KaxaNetReachStatus", nil];
        [dictionAry writeToFile:appInfoPath atomically:YES];
    }
    NSMutableDictionary *appInfo = [[NSMutableDictionary alloc] initWithContentsOfFile:appInfoPath];
    [appInfo setValue:value forKey:key];
    if (![appInfo writeToFile:appInfoPath atomically:YES])
        NSLog(@"Save appInfo feild");
}
- (NSString*)getAppInfoWithKey:(NSString*)key
{
    NSString *appInfoPath = [self getDocumentFullPath:@"appInfo.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:appInfoPath])
    {
        //NSString *appInfoBundle = [[NSBundle mainBundle] pathForResource:@"appInfo" ofType:@"plist"];
        //if (![[NSFileManager defaultManager] copyItemAtPath:appInfoBundle toPath:appInfoPath error:nil])
        //    NSLog(@"Copy appInfo faild");
        NSDictionary *dictionAry = [[NSDictionary alloc] initWithObjectsAndKeys:@"Reachable",@"KaxaNetReachStatus", nil];
        [dictionAry writeToFile:appInfoPath atomically:YES];
    }
    NSDictionary *appInfo = [[NSDictionary alloc] initWithContentsOfFile:appInfoPath];
    return [appInfo valueForKey:key];
}

- (NSInteger)currentLanguageInd
{
    //zh-Hant  繁體中文
    //zh-Hans  簡體中文
    NSString *language = [[NSLocale preferredLanguages] objectAtIndex:0];
    if ([language isEqualToString:@"zh-Hant"])
    {
        return 0;
    }
    else
    {
        return 1;
    }
    NSLog(@"%@",language);
}

#pragma mark 檢查email
- (BOOL)checkIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

#pragma mark - 判斷各種字串
- (NSString*)getEducationString:(NSInteger)eduInd
{
    switch (eduInd)
    {
        case 1:
            return NSLocalizedStringFromTable(@"Elementary", @"InfoPlist", nil);
            break;
        case 2:
            return NSLocalizedStringFromTable(@"Junior", @"InfoPlist", nil);
            break;
        case 3:
            return NSLocalizedStringFromTable(@"Senior", @"InfoPlist", nil);
            break;
        case 4:
            return NSLocalizedStringFromTable(@"University", @"InfoPlist", nil);
            break;
        default:
            return NSLocalizedStringFromTable(@"All", @"InfoPlist", nil);
            break;
    }
}
- (NSString*)getCourseString:(NSInteger)courseInd
{
    switch (courseInd)
    {
        case 1:
            return NSLocalizedStringFromTable(@"Chinese", @"InfoPlist", nil);
            break;
        case 2:
            return NSLocalizedStringFromTable(@"English", @"InfoPlist", nil);
            break;
        case 3:
            return NSLocalizedStringFromTable(@"Math", @"InfoPlist", nil);
            break;
        case 4:
            return NSLocalizedStringFromTable(@"Physical", @"InfoPlist", nil);
            break;
        case 5:
            return NSLocalizedStringFromTable(@"Chemistry", @"InfoPlist", nil);
            break;
        case 6:
            return NSLocalizedStringFromTable(@"Pandc", @"InfoPlist", nil);
            break;
        case 7:
            return NSLocalizedStringFromTable(@"Other", @"InfoPlist", nil);
            break;
        default:
            return NSLocalizedStringFromTable(@"All", @"InfoPlist", nil);
            break;
    }
}
- (NSString*)getPackageString:(NSString*)package
{
    NSString *desc;
    if ([package isEqualToString:@"1"])
    {
        desc = [NSString stringWithFormat:NSLocalizedStringFromTable(@"package", @"InfoPlist", nil)];
    }
    else {
        desc = [NSString stringWithFormat:NSLocalizedStringFromTable(@"unpackage", @"InfoPlist", nil)];
    }
    return desc;
}
- (NSString*)getQuestionStatus:(NSString*)status
{
    NSString *desc;
    if ([status isEqualToString:@"1"])
    {
        desc = [NSString stringWithFormat:NSLocalizedStringFromTable(@"closed", @"InfoPlist", nil)];
    }
    else {
        desc = [NSString stringWithFormat:NSLocalizedStringFromTable(@"active", @"InfoPlist", nil)];
    }
    return desc;
}

- (NSString*)getTopicNameWithIndex:(NSInteger)topicInd
{
    /*
     NSLocalizedStringFromTable(@"All", @"InfoPlist", @"我的專區"),
     NSLocalizedStringFromTable(@"Chinese", @"InfoPlist", nil),
     NSLocalizedStringFromTable(@"English", @"InfoPlist", nil),
     NSLocalizedStringFromTable(@"Math", @"InfoPlist", nil),
     NSLocalizedStringFromTable(@"Physical", @"InfoPlist", nil),
     NSLocalizedStringFromTable(@"Chemistry", @"InfoPlist", nil),
     NSLocalizedStringFromTable(@"PandC", @"InfoPlist", nil),
     NSLocalizedStringFromTable(@"Other", @"InfoPlist", nil),
     */
    NSString *desc = nil;
    switch (topicInd)
    {
        case 0:
            desc = [NSString stringWithFormat:NSLocalizedStringFromTable(@"All", @"InfoPlist", @"全部")];
            break;
        case 1:
            desc = [NSString stringWithFormat:NSLocalizedStringFromTable(@"Math", @"InfoPlist", nil)];
            break;
        case 2:
            desc = [NSString stringWithFormat:NSLocalizedStringFromTable(@"Physical", @"InfoPlist", nil)];
            break;
        case 3:
            desc = [NSString stringWithFormat:NSLocalizedStringFromTable(@"Chemistry", @"InfoPlist", nil)];
            break;
        case 4:
            desc = [NSString stringWithFormat:NSLocalizedStringFromTable(@"Physical2", @"InfoPlist", nil)];
            break;
        case 5:
            desc = [NSString stringWithFormat:NSLocalizedStringFromTable(@"Other", @"InfoPlist", nil)];
            break;
    }
    return desc;
}

#pragma mark - NSData to NSString
- (NSString*)base64forData:(NSData*)theData 
{
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding] autorelease];
}
@end
