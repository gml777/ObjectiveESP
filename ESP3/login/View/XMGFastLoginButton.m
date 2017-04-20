
#import "XMGFastLoginButton.h"

@implementation XMGFastLoginButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.y = 0;
    self.imageView.centerX = self.width * 0.5;

    [self.titleLabel sizeToFit];
    
    self.titleLabel.y = self.height - self.titleLabel.height;
    self.titleLabel.centerX = self.width * 0.5;
}

@end
