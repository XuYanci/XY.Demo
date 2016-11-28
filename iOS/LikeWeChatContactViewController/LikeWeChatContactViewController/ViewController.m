//
//  ViewController.m
//  LikeWeChatContactViewController
//
//  Created by Yanci on 16/11/28.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import "ViewController.h"
#import <ContactsUI/ContactsUI.h>
#import <Contacts/Contacts.h>

@interface ViewController ()<CNContactViewControllerDelegate,CNContactPickerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self requestAccessAddressBook];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





#pragma mark - CNContactPickerDelegate

- (BOOL)contactViewController:(CNContactViewController *)viewController
shouldPerformDefaultActionForContactProperty:(CNContactProperty *)property {
    return YES;
}

- (void)contactViewController:(CNContactViewController *)viewController
       didCompleteWithContact:(nullable CNContact *)contact {
    [viewController dismissViewControllerAnimated:YES completion:^{
    }];
}


- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)contactPicker:(CNContactPickerViewController *)picker
     didSelectContact:(CNContact *)contact {
    [picker dismissViewControllerAnimated:YES completion:^{
        CNContactStore *store = [[CNContactStore alloc]init];
        CNContact *newContact = [store unifiedContactWithIdentifier:contact.identifier keysToFetch:@[CNContactThumbnailImageDataKey,CNContactGivenNameKey,CNContactFamilyNameKey,CNContactPhoneNumbersKey,[CNContactViewController descriptorForRequiredKeys]] error:nil];
        
        CNContactViewController *viewController = [CNContactViewController viewControllerForNewContact:newContact];
        UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:viewController];
        viewController.delegate = self;
        [self presentViewController:navigationController animated:YES completion:nil];
        
    }];
}

- (void)contactPicker:(CNContactPickerViewController *)picker
didSelectContactProperty:(CNContactProperty *)contactProperty {
    
}



- (void)phoneNumberAddToContactAlert:(NSString *)phoneNumber {
    UIAlertController *phoneActionSheet =[UIAlertController alertControllerWithTitle:nil
                                                                             message:[NSString stringWithFormat:@"%@ \n 可能是一个电话号码,你可以",phoneNumber]
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *newContactAction = [UIAlertAction actionWithTitle:@"创建新联系人"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * _Nonnull action) {
        
        CNMutableContact * contact = [[CNMutableContact alloc]init];
        contact.phoneNumbers = @[[CNLabeledValue labeledValueWithLabel:CNLabelPhoneNumberiPhone value:[CNPhoneNumber phoneNumberWithStringValue:phoneNumber]]];
        CNContactViewController *contactViewController = [CNContactViewController viewControllerForNewContact:contact];
                                                                 
        contactViewController.delegate = self;
        UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:contactViewController];
        [self presentViewController:navigationController animated:YES completion:nil];
    }];
    
    UIAlertAction *addContactAction = [UIAlertAction actionWithTitle:@"添加到现有联系人" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        CNContactPickerViewController *pickerViewController = [[CNContactPickerViewController alloc]init];
        pickerViewController.displayedPropertyKeys = @[CNContactPhoneNumbersKey];
        pickerViewController.delegate = self;
        [self presentViewController:pickerViewController animated:YES completion:nil];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [phoneActionSheet addAction:newContactAction];
    [phoneActionSheet addAction:addContactAction];
    [phoneActionSheet addAction:cancelAction];
    
    [self presentViewController:phoneActionSheet
                                             animated:YES
                                           completion:nil];
}


#pragma mark - user events
- (IBAction)showPrompt:(id)sender {
    [self phoneNumberAddToContactAlert:@"18124198895"];
}


#pragma mark - funcs
- (BOOL)requestAccessAddressBook {
    int __block allow = 0;
    CNContactStore *store = [[CNContactStore alloc] init];
    dispatch_semaphore_t sema=dispatch_semaphore_create(0);
    [store requestAccessForEntityType:CNEntityTypeContacts
                    completionHandler:^(BOOL granted, NSError * _Nullable error) {
                        if (!granted) {
                            allow = 1;
                        }
                        dispatch_semaphore_signal(sema);
                    }];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    
    return allow;
}



@end
