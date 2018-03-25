// See http://iphonedevwiki.net/index.php/Logos

#import <UIKit/UIKit.h>
#import <XUI/XUI.h>
#import <objc/runtime.h>



@interface QQViewController : UIViewController
@end

@interface QQSettingsViewController : UIViewController
- (void)tweakItemTapped:(id)sender;
@end

@interface PreviewSecretPictureViewController : UIViewController
- (void)secretImage:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
@end

@interface QQToastView : UIView
+ (void)showTips:(NSString *)arg1 atRootView:(UIView *)arg2;
@end


%hook QQViewController

- (void)viewDidLoad {
    NSDictionary *dic = [[NSBundle mainBundle] infoDictionary];
    [dic setValue:@"com.tencent.mqq" forKey:@"CFBundleIdentifier"];
    %orig;
}

%end


%hook QQSettingsViewController

- (void)viewDidLoad {
    %orig;
    UIBarButtonItem *tweakItem = [[UIBarButtonItem alloc] initWithTitle:@"插件" style:UIBarButtonItemStylePlain target:self action:@selector(tweakItemTapped:)];
    [tweakItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = tweakItem; // 在 QQ 设置界面导航栏右上角添加按钮
}

%new
- (void)tweakItemTapped:(id)sender {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"QQRecallPatch" ofType:@"bundle"];
    NSString *xuiPath = [[NSBundle bundleWithPath:bundlePath] pathForResource:@"interface" ofType:@"json"];
    [self.navigationController pushViewController:[XUIListViewController XUIWithPath:xuiPath withBundlePath:bundlePath] animated:YES];
}

%end


%hook PreviewSecretPictureViewController

- (void)handleDidTakeScreenshot:(id)arg0 {
    
}

- (void)downloadImageHandler:(id)arg1 imageUrl:(id)arg2 isSuccess:(_Bool)arg3 downloadImage:(UIImage *)arg4 {
    %orig(arg1, arg2, arg3, arg4);
    if (arg3) {
        if (arg4 != nil)
        {
            id enabledVal = [[NSUserDefaults standardUserDefaults] objectForKey:@"AutoSaveFlashEnabled"];
            if (!enabledVal) {
                enabledVal = @(YES); // default value
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

%new
- (void)secretImage:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    [objc_getClass("QQToastView") showTips:@"闪照已成功保存到相机胶卷" atRootView:[[UIApplication sharedApplication] keyWindow]];
}

%end
