#import "DollarPointCloud.h"
#import "DollarP.h"

@implementation DollarPointCloud

@synthesize name, points;

- (id)initWithName:(NSString *)aName points:(NSArray *)somePoints {
    self = [super init];
    if (self) {
        [self setName:aName];
        
        somePoints = [DollarP resample:somePoints numPoints:DollarPNumPoints];
        somePoints = [DollarP scale:somePoints];
        somePoints = [DollarP translate:somePoints to:[DollarPoint origin]];
        
        [self setPoints:somePoints];
        self.originPoints = somePoints;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:self.originPoints.count];
    for (DollarPoint *point in self.originPoints) {
        [array addObject:@[@(point.id),@(point.x),@(point.y)]];
    }
    NSArray *resultArray = [NSArray arrayWithArray:array];
    [aCoder encodeObject:resultArray forKey:@"points"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    NSString *decodeName = [aDecoder decodeObjectForKey:@"name"];
    NSArray *pointArray = [aDecoder decodeObjectForKey:@"points"];
    NSMutableArray *dollarPointArray = [[NSMutableArray alloc] initWithCapacity:pointArray.count];
    for (NSArray *array in pointArray) {
        DollarPoint *point = [[DollarPoint alloc] initWithId:[array[0] intValue] x:[array[1] floatValue] y:[array[2] floatValue]];
        [dollarPointArray addObject:point];
    }
    self = [self initWithName:decodeName points:dollarPointArray];
    return self;
}



@end