//
//  ViewController.m
//  ImageDemo
//
//  Created by lanouhn on 16/3/26.
//  Copyright © 2016年 杨鹤. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIImageView *imageV;

@end

@implementation ViewController

/**
 *  imageView 懒加载
 */
- (UIImageView *)imageV
{
    self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(60, 100, 200, 250)];
    
    _imageV.backgroundColor = [UIColor yellowColor];
    
    _imageV.userInteractionEnabled = YES;
    
    _imageV.image = [UIImage imageNamed:@"ha"];
    

    
    return _imageV;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.imageV];
    
    [self addLongPressGR];

    [self addTapGR];
    
    [self addMakeButton];
    // Do any additional setup after loading the view, typically from a nib.
}

/**
 *  添加轻拍手势
 */
- (void)addTapGR
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap)];
    
    tap.numberOfTapsRequired = 1;
    
    tap.numberOfTouchesRequired = 1;
    
    [_imageV addGestureRecognizer:tap];
}


/**
 *  弹出选择获取照片渠道提示框
 */
- (void)handleTap
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"Choose Your Picture:" preferredStyle:(UIAlertControllerStyleActionSheet)];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"相机" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        [self pictureFromeCpmmera];
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"相册" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        [self pickerImageFromeLibrary];
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

/** 进入照相机 **/
- (void)pictureFromeCpmmera
{
    
    BOOL _isAvailable = [UIImagePickerController isCameraDeviceAvailable:(UIImagePickerControllerCameraDeviceRear)];

    if(!_isAvailable){
        
        [self alertActionWithTitle:@"相机好像坏啦" action:nil];
        
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    picker.allowsEditing = YES;
    
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
    

}

// 从相册中选择图片
- (void)pickerImageFromeLibrary
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    picker.allowsEditing = YES;
    
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
    
}



// 选择图片后触发
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    _imageV.image = [info objectForKey:UIImagePickerControllerEditedImage];

    [picker dismissViewControllerAnimated:YES completion:nil];
    
}














/**
 *  添加长按手势
 */
- (void)addLongPressGR
{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    
    // 设置长按手势最短的触发时间
    longPress.minimumPressDuration = 0.5;
    [_imageV addGestureRecognizer:longPress];
    
}

/**
 *  长按手势关联事件
 */
- (void)longPressAction:(UILongPressGestureRecognizer *)sender
{
    /**
     *  创建弹出框
     */
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"保存图片?" preferredStyle:(UIAlertControllerStyleAlert)];
    
    // /添加事件
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
         [self buttonAction];
        
    }]];
    
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
   
}


// 创建Button
- (void)addMakeButton
{
    UIButton *saveButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    
    saveButton.frame = CGRectMake(110, 400, 100, 30);
    
    saveButton.backgroundColor = [UIColor brownColor];
    
    [saveButton setTitle:@"保存"forState:(UIControlStateNormal)];
    
    [saveButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    
    saveButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:saveButton];
    
    [saveButton addTarget:self action:@selector(buttonAction) forControlEvents:(UIControlEventTouchUpInside)];
    
}


/**
 * 弹出保存成功, 并且进行保存
 */
- (void)buttonAction
{
    
    [self alertActionWithTitle:@"保存成功" action:^() {
        
        UIImageWriteToSavedPhotosAlbum(_imageV.image, nil, nil, nil);
        
    }];
    
}




// 提示框
- (void)alertActionWithTitle:(NSString *)title action:(void(^)())action
{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:(UIAlertControllerStyleAlert)];
    
    /**
     * 弹出提示框并保存图片
     */
    [self presentViewController:alertC animated:YES completion:^{
        
        if (action) {
            action();
        }
        
    }];
    
    /**
     * 添加延迟线程让视图消失
     */
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [alertC dismissViewControllerAnimated:YES completion:nil];
        
    });
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
