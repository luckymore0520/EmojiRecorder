#import <Foundation/Foundation.h>

@interface DollarPoint : NSObject

@property (nonatomic) float x;
@property (nonatomic) float y;
@property (nonatomic) int id;

+ (DollarPoint *)origin;

- (id)initWithId:(int)id x:(float)x y:(float)y;

@end