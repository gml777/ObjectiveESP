
#import "XMGLoginRegisterField.h"

@implementation XMGLoginRegisterField

- (void)awakeFromNib
{
    self.tintColor = [UIColor whiteColor];
    [self addTarget:self action:@selector(editBegin) forControlEvents:UIControlEventEditingDidBegin];
    
    [self addTarget:self action:@selector(editEnd) forControlEvents:UIControlEventEditingDidEnd];
    self.placeholderColor = [UIColor whiteColor];
   
}
- (void)editBegin
{
    UILabel *placeholderLabel = [self valueForKeyPath:@"placeholderLabel"];
    placeholderLabel.textColor = [UIColor whiteColor];

}
- (void)editEnd
{
    UILabel *placeholderLabel = [self valueForKeyPath:@"placeholderLabel"];
    placeholderLabel.textColor = [UIColor lightGrayColor];
}

@end
