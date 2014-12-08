/*
    initWithFrame
        Initializes the cell to set an image view which will have the proper image set at runtime, as well as set the
        unchecked image overtop in order to give visual feedback to the user.
 
    SetSelected
        This simply changes the unchecked image to checked and vice versa based on the selection state at runtime.
*/

#import "QFavouritesCustomCell.h"

@implementation QFavouritesCustomCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _restaurantLogo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        [self.contentView addSubview:_restaurantLogo];
        
        _checkmarkView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        
        UIImage* checkmarkImage = [UIImage imageNamed:@"selection_icon.png"];
        _checkmarkView.image = checkmarkImage;
        _checkmarkView.userInteractionEnabled = NO;
        [self.contentView addSubview:_checkmarkView];
        
        self.backgroundColor = [UIColor blackColor];
        
    }
    return self;
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if(selected){
        _checkmarkView.image = [UIImage imageNamed:@"checked_icon"];
    }else{
        _checkmarkView.image = [UIImage imageNamed:@"selection_icon.png"];
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
