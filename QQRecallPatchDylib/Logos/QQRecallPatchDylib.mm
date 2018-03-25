#line 1 "/Users/Zheng/Projects/QQRecallPatch/QQRecallPatchDylib/Logos/QQRecallPatchDylib.xm"


#import <UIKit/UIKit.h>
#import <XUI/XUI.h>

@interface QQViewController : UIViewController
@end

@interface QQSettingsViewController : UIViewController
- (void)tweakItemTapped:(id)sender;
@end

@interface PreviewSecretPictureViewController : UIViewController
- (void)secretImage:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
@end


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class QQSettingsViewController; @class PreviewSecretPictureViewController; @class QQViewController; 
static void (*_logos_orig$_ungrouped$QQViewController$viewDidLoad)(_LOGOS_SELF_TYPE_NORMAL QQViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$QQViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL QQViewController* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$QQSettingsViewController$viewDidLoad)(_LOGOS_SELF_TYPE_NORMAL QQSettingsViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$QQSettingsViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL QQSettingsViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$QQSettingsViewController$tweakItemTapped$(_LOGOS_SELF_TYPE_NORMAL QQSettingsViewController* _LOGOS_SELF_CONST, SEL, id); static void (*_logos_orig$_ungrouped$PreviewSecretPictureViewController$handleDidTakeScreenshot$)(_LOGOS_SELF_TYPE_NORMAL PreviewSecretPictureViewController* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$_ungrouped$PreviewSecretPictureViewController$handleDidTakeScreenshot$(_LOGOS_SELF_TYPE_NORMAL PreviewSecretPictureViewController* _LOGOS_SELF_CONST, SEL, id); static void (*_logos_orig$_ungrouped$PreviewSecretPictureViewController$downloadImageHandler$imageUrl$isSuccess$downloadImage$)(_LOGOS_SELF_TYPE_NORMAL PreviewSecretPictureViewController* _LOGOS_SELF_CONST, SEL, id, id, _Bool, UIImage *); static void _logos_method$_ungrouped$PreviewSecretPictureViewController$downloadImageHandler$imageUrl$isSuccess$downloadImage$(_LOGOS_SELF_TYPE_NORMAL PreviewSecretPictureViewController* _LOGOS_SELF_CONST, SEL, id, id, _Bool, UIImage *); static void _logos_method$_ungrouped$PreviewSecretPictureViewController$secretImage$didFinishSavingWithError$contextInfo$(_LOGOS_SELF_TYPE_NORMAL PreviewSecretPictureViewController* _LOGOS_SELF_CONST, SEL, UIImage *, NSError *, void *); 

#line 17 "/Users/Zheng/Projects/QQRecallPatch/QQRecallPatchDylib/Logos/QQRecallPatchDylib.xm"


static void _logos_method$_ungrouped$QQViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL QQViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    NSDictionary *dic = [[NSBundle mainBundle] infoDictionary];
    [dic setValue:@"com.tencent.mqq" forKey:@"CFBundleIdentifier"];
    _logos_orig$_ungrouped$QQViewController$viewDidLoad(self, _cmd);
}





static void _logos_method$_ungrouped$QQSettingsViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL QQSettingsViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    _logos_orig$_ungrouped$QQSettingsViewController$viewDidLoad(self, _cmd);
    UIBarButtonItem *tweakItem = [[UIBarButtonItem alloc] initWithTitle:@"插件" style:UIBarButtonItemStylePlain target:self action:@selector(tweakItemTapped:)];
    [tweakItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = tweakItem; 
}


static void _logos_method$_ungrouped$QQSettingsViewController$tweakItemTapped$(_LOGOS_SELF_TYPE_NORMAL QQSettingsViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id sender) {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"QQRecallPatch" ofType:@"bundle"];
    NSString *xuiPath = [[NSBundle bundleWithPath:bundlePath] pathForResource:@"interface" ofType:@"json"];
    [XUIListViewController presentFromTopViewControllerWithPath:xuiPath withBundlePath:bundlePath]; 
}





static void _logos_method$_ungrouped$PreviewSecretPictureViewController$handleDidTakeScreenshot$(_LOGOS_SELF_TYPE_NORMAL PreviewSecretPictureViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg0) {
    
}

static void _logos_method$_ungrouped$PreviewSecretPictureViewController$downloadImageHandler$imageUrl$isSuccess$downloadImage$(_LOGOS_SELF_TYPE_NORMAL PreviewSecretPictureViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2, _Bool arg3, UIImage * arg4) {
    _logos_orig$_ungrouped$PreviewSecretPictureViewController$downloadImageHandler$imageUrl$isSuccess$downloadImage$(self, _cmd, arg1, arg2, arg3, arg4);
    if (arg3) {
        if (arg4 != nil)
        {
            id enabledVal = [[NSUserDefaults standardUserDefaults] objectForKey:@"AutoSaveFlashEnabled"];
            if (!enabledVal) {
                enabledVal = @(YES); 
            }
            if (NO == [enabledVal boolValue]) {
                return;
            }
            id s_arg4 = objc_getAssociatedObject(self, _cmd);
            if (s_arg4) {
                return;
            }
            objc_setAssociatedObject(self, _cmd, arg4, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            UIImageWriteToSavedPhotosAlbum(arg4, self, @selector(secretImage:didFinishSavingWithError:contextInfo:), nil);
        }
    }
}


static void _logos_method$_ungrouped$PreviewSecretPictureViewController$secretImage$didFinishSavingWithError$contextInfo$(_LOGOS_SELF_TYPE_NORMAL PreviewSecretPictureViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UIImage * image, NSError * error, void * contextInfo) {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"插件提示"
                                                        message:@"闪照已成功保存到相机胶卷"
                                                       delegate:nil
                                              cancelButtonTitle:@"好"
                                              otherButtonTitles:nil];
    [alertView show];
}


static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$QQViewController = objc_getClass("QQViewController"); MSHookMessageEx(_logos_class$_ungrouped$QQViewController, @selector(viewDidLoad), (IMP)&_logos_method$_ungrouped$QQViewController$viewDidLoad, (IMP*)&_logos_orig$_ungrouped$QQViewController$viewDidLoad);Class _logos_class$_ungrouped$QQSettingsViewController = objc_getClass("QQSettingsViewController"); MSHookMessageEx(_logos_class$_ungrouped$QQSettingsViewController, @selector(viewDidLoad), (IMP)&_logos_method$_ungrouped$QQSettingsViewController$viewDidLoad, (IMP*)&_logos_orig$_ungrouped$QQSettingsViewController$viewDidLoad);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$QQSettingsViewController, @selector(tweakItemTapped:), (IMP)&_logos_method$_ungrouped$QQSettingsViewController$tweakItemTapped$, _typeEncoding); }Class _logos_class$_ungrouped$PreviewSecretPictureViewController = objc_getClass("PreviewSecretPictureViewController"); MSHookMessageEx(_logos_class$_ungrouped$PreviewSecretPictureViewController, @selector(handleDidTakeScreenshot:), (IMP)&_logos_method$_ungrouped$PreviewSecretPictureViewController$handleDidTakeScreenshot$, (IMP*)&_logos_orig$_ungrouped$PreviewSecretPictureViewController$handleDidTakeScreenshot$);MSHookMessageEx(_logos_class$_ungrouped$PreviewSecretPictureViewController, @selector(downloadImageHandler:imageUrl:isSuccess:downloadImage:), (IMP)&_logos_method$_ungrouped$PreviewSecretPictureViewController$downloadImageHandler$imageUrl$isSuccess$downloadImage$, (IMP*)&_logos_orig$_ungrouped$PreviewSecretPictureViewController$downloadImageHandler$imageUrl$isSuccess$downloadImage$);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UIImage *), strlen(@encode(UIImage *))); i += strlen(@encode(UIImage *)); memcpy(_typeEncoding + i, @encode(NSError *), strlen(@encode(NSError *))); i += strlen(@encode(NSError *)); _typeEncoding[i] = '^'; _typeEncoding[i + 1] = 'v'; i += 2; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$PreviewSecretPictureViewController, @selector(secretImage:didFinishSavingWithError:contextInfo:), (IMP)&_logos_method$_ungrouped$PreviewSecretPictureViewController$secretImage$didFinishSavingWithError$contextInfo$, _typeEncoding); }} }
#line 84 "/Users/Zheng/Projects/QQRecallPatch/QQRecallPatchDylib/Logos/QQRecallPatchDylib.xm"
