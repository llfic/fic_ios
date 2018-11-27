//
//  MovieDetailViewController.m
//  FIC
//
//  Created by fic on 2018/10/31.
//  Copyright © 2018年 fic. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "FilmInfoCell.h"
#import "FilmModel.h"
#include "FilmInfoModel.h"
#import "ZZWTool.h"
#import "InvestViewController.h"
#import "EarningsReportViewController.h"
#import "ZZWDataSaver.h"
#import "ActorModel.h"
#import "UIButton+ImageTitleSpacing.h"
#import "CustomerServiceViewController.h"


@interface MovieDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSArray *adImges;
@property (weak, nonatomic) IBOutlet UIButton *moniBtn;
@property(nonatomic,strong)NSArray *actorModelArr;
@property (weak, nonatomic) IBOutlet UIButton *investBtn;
@property(nonatomic,strong)FilmInfoModel *model;
@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor blackColor];
    [self.moniBtn setImage:[UIImage imageNamed:@"moni"] forState:UIControlStateNormal];
    self.investBtn.backgroundColor = ButtonBg_red;
    
    
    //tableview 从屏幕顶部开始布局，而不是导航栏底部
    self.extendedLayoutIncludesOpaqueBars = YES;
    if (@available(iOS 11.0, *)) {
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.edgesForExtendedLayout = UIRectEdgeTop;//保证tableview底部不被tabbar遮挡
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
}
-(void)setData{
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@[@"陈思诚",@"王宝强",@"张子枫",@"潘粤明",@"妻夫木聪"] forKey:@"唐人街探案3"];
    [dic setObject:@[@"杨龙",@"谢霆锋",@"吴亦凡",@"黄子韬",@"白敬亭"] forKey:@"灌篮高手的契约"];
    [dic setObject:@[@"王丹",@"沈腾",@"马丽",@"乔杉",@"雷志龙"] forKey:@"没头脑和不高兴的奇妙之旅"];
    [dic setObject:@[@"雷尼",@"刘德华",@"谢霆锋",@"余男",@"赵又廷"] forKey:@"索马里行动"];
    [dic setObject:@[@"宋晓飞",@"王宝强",@"包贝尔",@"柳岩",@"雷佳音"] forKey:@"债囧之愤怒的小强"];
    [dic setObject:@[@"佩里",@"黄轩",@"杰森",@"廖凡",@"托尼·贾"] forKey:@"猎魔行动"];
    [dic setObject:@[@"林超贤",@"彭于晏",@"辛止蕾",@"王彦霖"] forKey:@"紧急救援"];
    [dic setObject:@[@"吴京",@"吴京",@"余男",@"卢静姗"] forKey:@"战狼3"];
    [dic setObject:@[@"黄渤",@"黄渤",@"舒淇",@"王宝强",@"张兴艺"] forKey:@"一出好戏"];
    [dic setObject:@[@"吴昱翰",@"黄才伦",@"宋阳",@"艾伦",@"卢靖姗"] forKey:@"李茶的姑妈"];
    [dic setObject:@[@"孙周",@"艾伦",@"王智",@"鲁诺"] forKey:@"人间-喜剧"];//没有数据
    [dic setObject:@[@"宁浩",@"黄渤",@"沈腾",@"凯特·纳尔逊",@"马修·莫里森"] forKey:@"疯狂的外星人"];
    [dic setObject:@[@"钱国伟",@"陈小春",@"谢天华",@"李晓峰",@"朱永棠"] forKey:@"孤战"];
    
    NSMutableDictionary *briefDic = [NSMutableDictionary dictionary];
    [briefDic setObject:@"投资《唐人街探案2》的万达集团院线总裁曾茂军透露，《唐人街探案2》终将留下一些伏笔，替计划到日本拍摄的第三部铺梗，第三部的故事结构也已经大致完稿。" forKey:@"唐人街探案3"];
    [briefDic setObject:@"中美合拍，好莱坞顶级制作。主旋律商业大片。" forKey:@"索马里行动"];
    [briefDic setObject:@"影片投资企业：飓风影业、核子动力影业、中视玖翔影业、龙麒麟影业、开心麻花、新动影业、中巢股份" forKey:@"没头脑和不高兴的奇妙之旅"];
    [briefDic setObject:@"真实的新闻故事背景，让世界恐惧的尸体藏毒走私大案发生做墨西哥境内。重磅推出的一部全球发行的中国警匪大片，一部真正好看的好莱坞风格中国电影。" forKey:@"猎魔行动"];
    [briefDic setObject:@"据艺恩 2016~2017 年中国观众调研报告显示，青春爱情类型 的影片在国内拥有第二高的观众基础，市场号召力。结合本片演员的票房号召力，使得本片原生IP的影响力，将吸引 70后80后90后的庞大观影人群 涌入影院。" forKey:@"灌篮高手的契约"];
    [briefDic setObject:@"“囧”系列巨作，延续 大热IP,引爆观影热潮。一线实力派明星出演，续写票房神话。" forKey:@"债囧之愤怒的小强"];
    [briefDic setObject:@"影片投资企业：博纳影业、北京文化、新影联影业、飓风影业。" forKey:@"紧急救援"];
    [briefDic setObject:@"影片投资企业：登峰影业、北京文化、新影联影业、飓风影业。" forKey:@"战狼3"];
    [briefDic setObject:@"《一出好戏》是由上海瀚纳影视文化传媒有限公司制作的喜剧片，由黄渤执导，黄渤、王宝强、舒淇、张艺兴、于和伟、王迅联袂主演。该片于2018年8月10日在中国内地上映 。" forKey:@"一出好戏"];
    [briefDic setObject:@"《李茶的姑妈》是由吴昱翰执导，黄才伦、艾伦、宋阳等领衔主演的喜剧片。" forKey:@"李茶的姑妈"];
    [briefDic setObject:@"原名-《时代狂人》，在广州顺利杀青，新生代喜剧加上实力老戏骨加盟，将为大家上演一段笑中带泪的疯狂喜剧，令人期待。" forKey:@"人间-喜剧"];
    [briefDic setObject:@"故事灵感来源于刘慈欣的短篇科幻小说《乡村教师》，剧本筹备了五年，由刘慈欣老师、编剧孙小杭等人的参与制作。" forKey:@"疯狂的外星人"];
    [briefDic setObject:@"2017年10月3日，在北京举办启动发布会，总制片人孙建、监制王大为、导演钱伟国携主演陈小春、谢天华、朱永棠亮相，香港经典“兄弟天团”的重聚勾起了广大影迷的回忆。" forKey:@"孤战"];
    
    
    
    NSMutableDictionary *synopsisDic = [NSMutableDictionary dictionary];
    [synopsisDic setObject:@"在《唐探2》结局的部分，唐仁和野田昊都接到一个来自日本的电话，大呼案子太难，提前透露了第三部的故事地点——东京。陈思诚透露，《唐探3》已被列入拍摄计划，未来将在2020年大年初一和观众见面。" forKey:@"唐人街探案3"];
    [synopsisDic setObject:@"我国公安人员做海外将不法商人肖老板逮捕，并乔装成普通中企员工乘货船将肖老板押送回国。" forKey:@"索马里行动"];
    [synopsisDic setObject:@"有才和高兴是从小一起长大的好朋友，他们喜欢逗比、有梦想。有才是一名专车司机，高兴是一名宠物结扎师。两个人挤在一间合租屋内，为梦想的第一桶金努力着。但是，梦想和现实之间巨大的距离。" forKey:@"没头脑和不高兴的奇妙之旅"];
    [synopsisDic setObject:@"圣诞夜的温哥华机场，海关安检发现一名携带“卡芬太尼”新型毒品的中国人，杰森是负责十年前追缴从墨西哥贩卖枪支到中国的负责人。中国公安部指示，中美联合作战，一举歼灭该制毒贩毒国际团伙。" forKey:@"猎魔行动"];
    [synopsisDic setObject:@"岛城的高中篮球联赛代表了鲁省的最高水准，冠军争夺更是异常激烈。新赛季伊始便猛料频出：传统劲旅22中主力大前锋马龙转学到死对头5中。祸不单行，22中主教练林菲称病在省际决赛即将到来的这个学期请长假。" forKey:@"灌篮高手的契约"];
    [synopsisDic setObject:@"影片主要讲述了伊黛在宾馆将提包取错意外发现丝绸之路藏宝图，在生活所迫下将图换钱生存，由于迷失落入沙漠魔鬼城堡过着原始生活，伊黛带领部落致富；易路艰辛找到妹妹并挖出盗图人，一路囧途上不断发生啼笑皆非的故事。" forKey:@"债囧之愤怒的小强"];
    [synopsisDic setObject:@"《紧急救援》这部影片是由林超贤执导，彭于晏主演，将在在2019年5月上映，据悉，该影片是一部讲述海上的救援行动故事，敬请期待！" forKey:@"紧急救援"];
    [synopsisDic setObject:@"剧情主要是围绕冷锋只身营救龙小云展开。战狼二最后通过彩蛋视频得知，龙小云(余男饰演)被反政府的雇佣军抓获以后，被雇佣军枪杀但没有死去的消息。所以冷峰(吴京饰演)从非洲回到国内并且从新加入战狼准备营救龙小云。而龙小云则是被坦桑利亚的一个国家红十字会组织给救了下来!得知这个消息冷峰去找龙小云! 但同时杰瑞61弗兰科(尼古拉斯，沃尼玛饰演)也知道了这个消息，他带着欧州最臭名昭著的雇佣军来劫持龙小云，因为他要给他的战友报仇杀死冷锋......" forKey:@"战狼3"];
    [synopsisDic setObject:@"马进（黄渤饰）欠下债务，与远房表弟小兴（张艺兴饰）在底层社会摸爬滚打，习惯性的买彩票，企图一夜爆富，并迎娶自己的同事姗姗（舒淇饰）。一日，公司全体员工出海团建，途中，马进收到了彩票中头奖的信息，六千万，就在马进狂喜自己翻身的日子终于到来之际，一场突如其来的滔天巨浪打破了一切。苏醒过来的众人发现身处荒岛，丧失了一切与外界的联系。在封闭小岛的背景下，失去规则、失去阶级、失去财富的他们呈现出人性百态的浮世绘。" forKey:@"一出好戏"];
    [synopsisDic setObject:@"李茶（宋阳饰）是个穷小子，姑妈（卢靖姗饰）却是全球女首富，自打李茶出生后二人便未曾谋面。为了娶到势利眼富商的女儿，李茶恳请姑妈出面牵线搭桥，可各怀鬼胎的一行人却误将男员工黄沧海（黄才伦饰）认作姑妈。为了各自的利益，黄沧海、李茶连同梁杰瑞（艾伦饰）三个人将计就计组团来假扮姑妈，正当众人纷纷讨好这位假姑妈时，神秘的真姑妈现身了，一连串的爆笑故事也发生了。" forKey:@"李茶的姑妈"];
    [synopsisDic setObject:@"爱讲鸡汤的电台主播濮通，一夜之间被卷进一场莫名其妙的阴谋旋涡。怀揣不可告人秘密的黑帮大佬有着离奇出身的本地首富一个身无分文的富二代，各种奇葩轮番登场。而荒诞的是，濮通这个小人物却一不小心左右了这些大人物的命运。" forKey:@"人间-喜剧"];
    [synopsisDic setObject:@"训猴员耿浩承诺为了儿子演猴戏，猴子却被从天而降的外星人砸伤，情急下遂训练外星人顶替。表演前夕外星人重获超能力，惩罚耿浩后欲离开。岂料外星人被好友大飞泡了酒，而此时一直寻找外星人的美国人找上门来..." forKey:@"疯狂的外星人"];
    [synopsisDic setObject:@"电影《孤战》由香港导演钱国伟执导、孙建担纲总制片人、王大为跨刀总监制、香港经典“兄弟天团”陈小春、谢天华、林晓峰、朱永棠霸气领衔主演。" forKey:@"孤战"];
    
    NSMutableDictionary * synopsisImageDic = [NSMutableDictionary dictionary];
    [synopsisImageDic setObject:@"tangren3_1&tangren3_2" forKey:@"唐人街探案3"];
    [synopsisImageDic setObject:@"somali_1&somali_2" forKey:@"索马里行动"];
    [synopsisImageDic setObject:@"meitongnao_1&meitongnao_2" forKey:@"没头脑和不高兴的奇妙之旅"];
    [synopsisImageDic setObject:@"liemo_1&liemo_2" forKey:@"猎魔行动"];
    [synopsisImageDic setObject:@"guanlan_1&guanlan_2" forKey:@"灌篮高手的契约"];
    [synopsisImageDic setObject:@"zhaijiong_1&zhaijiong_2" forKey:@"债囧之愤怒的小强"];
    [synopsisImageDic setObject:@"jjjy_剧情照&jjjy_项目照" forKey:@"紧急救援"];
    [synopsisImageDic setObject:@"zhanglang_简介&zhanglang_项目剧照" forKey:@"战狼3"];
    [synopsisImageDic setObject:@"yichu_剧照1&yichu_剧照2" forKey:@"一出好戏"];
    [synopsisImageDic setObject:@"licha_剧照3&licha_剧照4" forKey:@"李茶的姑妈"];
    [synopsisImageDic setObject:@"rj_项目照&rj_剧情照3" forKey:@"人间-喜剧"];
    [synopsisImageDic setObject:@"fk_剧照1&fk_剧照4" forKey:@"疯狂的外星人"];
    [synopsisImageDic setObject:@"guzhan_1&guzhan_2" forKey:@"孤战"];
    
    
    
//    @[@"tangrenjie",@"guanlangaoshou",@"jinjiyuanjiu",@"meitounao",@"liemo",@"zhaijiong",@"zhanlang",@"suomali"];
    NSMutableDictionary * imageDic = [NSMutableDictionary dictionary];
    [imageDic setObject:@"tangrenjie" forKey:@"唐人街探案3"];
    [imageDic setObject:@"suomali" forKey:@"索马里行动"];
    [imageDic setObject:@"meitounao" forKey:@"没头脑和不高兴的奇妙之旅"];
    [imageDic setObject:@"liemo" forKey:@"猎魔行动"];
    [imageDic setObject:@"guanlangaoshou" forKey:@"灌篮高手的契约"];
    [imageDic setObject:@"zhaijiong" forKey:@"债囧之愤怒的小强"];
    [imageDic setObject:@"jinjiyuanjiu" forKey:@"紧急救援"];
    [imageDic setObject:@"zhanlang" forKey:@"战狼3"];
    [imageDic setObject:@"yichuhaoxi" forKey:@"一出好戏"];
    [imageDic setObject:@"licha" forKey:@"李茶的姑妈"];
    [imageDic setObject:@"renjian" forKey:@"人间-喜剧"];
    [imageDic setObject:@"fengkuang" forKey:@"疯狂的外星人"];
    [imageDic setObject:@"guzhan" forKey:@"孤战"];
    
    
    ZZWDataSaver *saver = [ZZWDataSaver shareManager];
    [saver createActorDB];
    _actorModelArr = [saver queryActorsWithFilmName:self.filmName];
    if (_actorModelArr.count == 0) {
            NSArray *names = [dic objectForKey:self.filmName];
            for (NSInteger i = 0; i < names.count; i++) {
                ActorModel *model = [ActorModel new];
                model.actorName = names[i];
                model.actorImage = names[i];
                model.filmName = self.filmName;
                if (i == 0) {
                    model.actorType = 1;
                }
        //        else if(i == 1){
        //            model.actorType = 3;
        //        }
                else{
                    model.actorType = 2;
                }
                [saver addActorModel:model];
            }
        _actorModelArr = [saver queryActorsWithFilmName:self.filmName];
    }
    
    [saver createFilmDetailDB];
    NSArray *arr = [saver queryFilmDetailWithFilmName:self.filmName];
    if (arr.count == 0) {
        FilmInfoModel *model = [FilmInfoModel new];
        model.image = [imageDic objectForKey:self.filmName];;
        model.name = self.filmName;
        model.type = @"类型：喜剧、动作、冒险";
        model.address = @"中国大陆";
        model.time = @"100-110分钟";
        model.publishTime = @"预计2019-10上映";
        model.investFIC = [NSString stringWithFormat:@"0"];
        model.wantSeeCount = [NSString stringWithFormat:@"93884"];
        model.dianZanCount = @"1314";
        model.totalFIC = [NSString stringWithFormat:@"待定"];
        model.investPersonCount = [NSString stringWithFormat:@"1024"];
        model.attentionCount = [NSString stringWithFormat:@"90493"];
        model.proejectBrief = [briefDic objectForKey:self.filmName];
        model.synopsis = [synopsisDic objectForKey:self.filmName];
        model.synopsisImages = [synopsisImageDic objectForKey:self.filmName];
        [saver addFilmInfoModel:model];
        
        arr = [saver queryFilmDetailWithFilmName:self.filmName];
    }
    _model = arr.firstObject;
}


-(void)setNavi{
    self.NaviStyle = DefaultNavi;
}
-(void)setTable{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //    self.tableView.backgroundColor = DefaultBgColor;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 16, 0, 0);//设置分割线长度
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//隐藏分割线
//    [self.tableView registerNib:[UINib nibWithNibName:FilmCell_Name bundle:nil] forCellReuseIdentifier:FilmCell_Identifier];
    //    [self.tableView registerClass:[FilmCell class] forCellReuseIdentifier:FilmCell_Identifier];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];//隐藏多余的cell
    //    self.tableView.scrollEnabled = NO;//table不能滚动
    self.tableView.tableHeaderView = [self createTableHeadView];
    //    self.tableView.bounces = NO;
}
-(UIView *)createTableHeadView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    
    UIImage *image = [UIImage imageNamed:@"bg-guanlan"];
    CGFloat height = (image.size.height/image.size.width)*ScreenWidth + 20;
    

    CGFloat marigin = 16.0;
    
     //顶部白色背景
    UIView *topBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, height)];
    topBgView.backgroundColor = WhiteColor;
    [view addSubview:topBgView];
    
    
//    // 顶部背景
//    UIImageView *topBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, height)];
//    topBgView.userInteractionEnabled = YES;//UIImageView打开交互的功能
//    topBgView.image = image;
//    [view addSubview:topBgView];
    
    
    //电影图片
    CGFloat originY1 = 88;
    if (ScreenWidth == 320) {
        originY1 = 60 + 20;
    }
    image = [UIImage imageNamed:self.model.image];
    UIImageView *topImgV = [[UIImageView alloc] initWithFrame:CGRectMake(marigin, originY1, image.size.width, image.size.height)];
    topImgV.image = image;
    topImgV.layer.cornerRadius = ViewCorner;
    topImgV.layer.masksToBounds = YES;
    [topBgView addSubview:topImgV];
    CGFloat originX = marigin*2 + image.size.width;
    
    CGFloat originY = originY1;
    
    UIFont *font = FontDefault;
    if (ScreenWidth == 320) {
        font = FontSmallest;
    }
    
    // 电影名字
    UILabel *nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(originX, originY, ScreenWidth - originX, 20)];
    nameLbl.textAlignment = NSTextAlignmentLeft;
    nameLbl.textColor = BlackColor;
    nameLbl.text = self.model.name;
    nameLbl.font = [UIFont fontWithName:FontNameBold size:FontBig.pointSize];
    
    [topBgView addSubview:nameLbl];
    
    originY += 40;
    // 类型
    UILabel *typeLbl = [[UILabel alloc] initWithFrame:CGRectMake(originX, originY, ScreenWidth - originX, 20)];
    typeLbl.textAlignment = NSTextAlignmentLeft;
    typeLbl.text = self.model.type;
    typeLbl.textColor = TextMidGray;
    typeLbl.font = font;
    [topBgView addSubview:typeLbl];
    
    originY += 25;
    // 地点、时长
    UILabel *addressLbl = [[UILabel alloc] initWithFrame:CGRectMake(originX, originY, ScreenWidth - originX, 20)];
    addressLbl.textAlignment = NSTextAlignmentLeft;
    
    addressLbl.text = [NSString stringWithFormat:@"%@/%@",self.model.address,self.model.time];
    addressLbl.textColor = TextMidGray;
    addressLbl.font = font;
    [topBgView addSubview:addressLbl];
    
    originY += 25;
    // 上映时间
    UILabel *timeLbl = [[UILabel alloc] initWithFrame:CGRectMake(originX, originY, ScreenWidth - originX, 20)];
    timeLbl.textAlignment = NSTextAlignmentLeft;
    timeLbl.text =  self.model.publishTime;
    timeLbl.textColor = TextMidGray;
    timeLbl.font = font;
    [topBgView addSubview:timeLbl];
    
    originY += 40;
    // 想看数字
    UILabel *countLbl = [[UILabel alloc] initWithFrame:CGRectMake(originX, originY, ScreenWidth - originX, 20)];
    countLbl.textAlignment = NSTextAlignmentLeft;
//    countLbl.attributedText = [ZZWTool getAttributeStrWithFrontStr:self.model.wantSeeCount frontColor:TextRed behindStr:@"人想看" behindColor: TextMaxGray];
    countLbl.text = [NSString stringWithFormat:@"%@人想看",self.model.wantSeeCount];
    countLbl.textColor = TextRed;
    countLbl.font = font;
    [topBgView addSubview:countLbl];
  
    originY = originY1 + image.size.height + 20;
    if (ScreenWidth == 320) {
        originY = originY1 + image.size.height + 10;
    }
    
    
//    CGFloat buttonHeight = 40;
//    //票务预售
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(marigin, originY, (ScreenWidth - marigin*3)/2, buttonHeight);
//    [button setTitle:@"票务预售" forState:UIControlStateNormal];
//    [button setImage:[UIImage imageNamed:@"heart"] forState:UIControlStateNormal];
//    button.titleLabel.font = font;
//    [button addTarget:self action:@selector(sellTickets:) forControlEvents:UIControlEventTouchUpInside];
//    button.backgroundColor = [UIColor colorWithHexString:@"555352"];
//    button.layer.cornerRadius = 5.0f;
//    button.layer.masksToBounds = YES;
//    [bgImgV addSubview:button];
//
//    //衍生品预售
//    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    button2.frame = CGRectMake(marigin*2 + (ScreenWidth - marigin*3)/2, originY, (ScreenWidth - marigin*3)/2, buttonHeight);
//    [button2 setTitle:@"衍生品预售" forState:UIControlStateNormal];
//    [button2 setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
//    [button2 addTarget:self action:@selector(sellGoods:) forControlEvents:UIControlEventTouchUpInside];
//    button2.backgroundColor = [UIColor colorWithHexString:@"555352"];
//    button2.layer.cornerRadius = 5.0f;
//    button2.layer.masksToBounds = YES;
//    [bgImgV addSubview:button2];
//    button2.titleLabel.font = font;
    
    topBgView.frame = CGRectMake(0, 0, ScreenWidth, height);
    if (self.type == MovieDetailViewController_Normal) {
        
        // 中间背景视图
        UIView *midBgView = [[UIView alloc] initWithFrame:CGRectMake(marigin, originY, ScreenWidth -marigin*2, 160)];
        midBgView.layer.masksToBounds = NO;// 设置为NO 才会有阴影的效果
        midBgView.backgroundColor = [UIColor whiteColor];
        midBgView.layer.shadowColor = BlackColor.CGColor;
        midBgView.layer.shadowOffset = CGSizeZero;
        midBgView.layer.shadowOpacity = ShadowOpacity;
        midBgView.layer.shadowRadius = ViewCorner*2;
        midBgView.layer.cornerRadius = ViewCorner;
        midBgView.layer.borderWidth = BorderWidth;
        midBgView.layer.borderColor = WhiteColor.CGColor;
        
        // 标题
        UILabel *investTitleLbl = [[UILabel alloc] initWithFrame:CGRectMake(marigin, 10, midBgView.frame.size.width - marigin*2, 30)];
        investTitleLbl.text = @"投资进度";
        investTitleLbl.font = [UIFont fontWithName:FontNameBold size:FontDefault.pointSize];
        [midBgView addSubview:investTitleLbl];
        
        //百分比进度条
        UIView *percentLine = [[UIView alloc] initWithFrame:CGRectMake(marigin, investTitleLbl.frame.origin.y + investTitleLbl.frame.size.height + 10, midBgView.frame.size.width - marigin*2, ProgressHeight)];
        percentLine.backgroundColor = ProgressBgGray;
        percentLine.layer.cornerRadius = percentLine.frame.size.height/2;
        percentLine.layer.masksToBounds = YES;
        [midBgView addSubview:percentLine];
        
        //FIC总投资
        UILabel *totalLbl = [[UILabel alloc] initWithFrame:CGRectMake(marigin, percentLine.frame.origin.y + percentLine.frame.size.height + 10, 150, 20)];
        totalLbl.attributedText = [ZZWTool getAttributeStrWithFrontStr:self.model.investFIC frontColor:TextRed behindStr:[NSString stringWithFormat:@" FIC / %@ FIC",self.model.totalFIC] behindColor:TextMidGray];
        totalLbl.font = FontSmall;
        [midBgView addSubview:totalLbl];
        
        //参投人数
        UILabel *peopleLbl = [[UILabel alloc] initWithFrame:CGRectMake(midBgView.frame.size.width - marigin - 100, percentLine.frame.origin.y + percentLine.frame.size.height + 10, 100, 20)];
        peopleLbl.attributedText = [ZZWTool getAttributeStrWithFrontStr:@"3633" frontColor:TextRed behindStr:@"人参投" behindColor:TextMidGray];
        peopleLbl.textAlignment = NSTextAlignmentRight;
        peopleLbl.font = FontSmall;
        [midBgView addSubview:peopleLbl];
        
        // 四个 button
        NSArray *titles = @[@"1841",@"3594",@"客服"];
        NSArray *images = @[@"icon_dianzan",@"icon_guanz",@"icon_kefu"];
        image = [UIImage imageNamed:@"icon_dianzan"];
        CGSize size = CGSizeMake(image.size.width, image.size.height);
//        CGSize size = CGSizeMake(30, 30);
        for (NSInteger i = 0; i < titles.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.selected = NO;
            button.frame = CGRectMake((midBgView.frame.size.width/titles.count)*i + (midBgView.frame.size.width/titles.count -size.width)/2, totalLbl.frame.origin.y + totalLbl.frame.size.height+10, size.width, size.height);
            [button setBackgroundImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
            button.tag = 100 + i;
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [midBgView addSubview:button];

            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((midBgView.frame.size.width/titles.count)*i, button.frame.origin.y  + button.frame.size.height, midBgView.frame.size.width/titles.count, 20)];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = FontSmall;
            label.text = titles[i];
            label.tag = 200 + i;
            [midBgView addSubview:label];
        }
        
        [topBgView addSubview:midBgView];
        
        
//        height += 30;
//
//        // 投资介绍
//        UILabel *desLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, height, ScreenWidth, 20)];
//        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"已投"];
//        [text addAttribute:NSForegroundColorAttributeName value:TextMidGray range:NSMakeRange(0, 2)];
//        NSMutableAttributedString *str = [ZZWTool getAttributeStrWithFrontStr:self.model.investFIC frontColor:TextRed behindStr:[NSString stringWithFormat:@" FIC / %@ FIC",self.model.totalFIC] behindColor:TextMidGray];
//
//        [text appendAttributedString:str];
//        desLbl.attributedText = text;
//        desLbl.textAlignment = NSTextAlignmentCenter;
//        [view addSubview:desLbl];
//
//        height += 20;
//
//        // 四个 button
//        NSArray *titles = @[@"已投",@"点赞",@"关注",@"淘影"];
//        NSArray *subTitles = @[@"1841",@"3594",@"1965",@"客服"];
//        NSArray *images = @[@"yitou",@"dianzan",@"guanzhu",@"kefu"];
//        image = [UIImage imageNamed:@"piaowu"];
//        for (NSInteger i = 0; i < titles.count; i++) {
//            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//            button.selected = NO;
//            button.frame = CGRectMake((ScreenWidth/titles.count)*i + (ScreenWidth/titles.count -image.size.width)/2, height + 20, image.size.width, image.size.height);
//            [button setBackgroundImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
//    //        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
//            [button addTarget:self action:@selector(actionType:) forControlEvents:UIControlEventTouchUpInside];
//            button.tag = 100 + i;
//            [view addSubview:button];
//
//            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth/titles.count)*i, button.frame.origin.y  + button.frame.size.height + 8, ScreenWidth/titles.count, 20)];
//            label.textAlignment = NSTextAlignmentCenter;
//            label.font = FontSmall;
//            label.text = titles[i];
//            [view addSubview:label];
//
//            UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth/titles.count)*i, label.frame.origin.y  + label.frame.size.height, ScreenWidth/titles.count, 20)];
//            label2.textAlignment = NSTextAlignmentCenter;
//            label2.font = FontSmall;
//            label2.tag = 200 + i;
//            label2.text = subTitles[i];
//            [view addSubview:label2];
//        }
//
//        originY = height + 20 + image.size.height + 20 + 20 + 20;
//        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, originY, ScreenWidth, 10)];
//        line.backgroundColor = ProgressBgGray;
//        [view addSubview:line];
    }else{
        // 中间背景视图
        UIView *midBgView = [[UIView alloc] initWithFrame:CGRectMake(marigin, originY, ScreenWidth -marigin*2, 160)];
        midBgView.layer.masksToBounds = NO;// 设置为NO 才会有阴影的效果
        midBgView.backgroundColor = [UIColor whiteColor];
        midBgView.layer.shadowColor = BlackColor.CGColor;
        midBgView.layer.shadowOffset = CGSizeZero;
        midBgView.layer.shadowOpacity = ShadowOpacity;
        midBgView.layer.shadowRadius = ViewCorner*2;
        midBgView.layer.cornerRadius = ViewCorner;
        midBgView.layer.borderWidth = BorderWidth;
        midBgView.layer.borderColor = WhiteColor.CGColor;
        
        // 标题
        UILabel *investTitleLbl = [[UILabel alloc] initWithFrame:CGRectMake(marigin, 10, midBgView.frame.size.width - marigin*2, 30)];
        investTitleLbl.text = @"投资进度";
        investTitleLbl.font = [UIFont fontWithName:FontNameBold size:FontDefault.pointSize];
        [midBgView addSubview:investTitleLbl];
        
        //百分比进度条
        UIView *percentLine = [[UIView alloc] initWithFrame:CGRectMake(marigin, investTitleLbl.frame.origin.y + investTitleLbl.frame.size.height + 10, midBgView.frame.size.width - marigin*2, ProgressHeight)];
        percentLine.backgroundColor = TextRed;
        percentLine.layer.cornerRadius = percentLine.frame.size.height/2;
        percentLine.layer.masksToBounds = YES;
        [midBgView addSubview:percentLine];
        
        //FIC总投资
        UILabel *totalLbl = [[UILabel alloc] initWithFrame:CGRectMake(marigin, percentLine.frame.origin.y + percentLine.frame.size.height + 10, 150, 20)];
        totalLbl.attributedText = [ZZWTool getAttributeStrWithFrontStr:@"6,000,000" frontColor:TextRed behindStr:@"已完成" behindColor:TextMidGray];
        totalLbl.font = FontSmall;
        [midBgView addSubview:totalLbl];
        
        //参投人数
        UILabel *peopleLbl = [[UILabel alloc] initWithFrame:CGRectMake(midBgView.frame.size.width - marigin - 100, percentLine.frame.origin.y + percentLine.frame.size.height + 10, 100, 20)];
        peopleLbl.attributedText = [ZZWTool getAttributeStrWithFrontStr:@"3633" frontColor:TextRed behindStr:@"人参投" behindColor:TextMidGray];
        peopleLbl.textAlignment = NSTextAlignmentRight;
        peopleLbl.font = FontSmall;
        [midBgView addSubview:peopleLbl];
        
        //周期
        UILabel *periodLbl = [[UILabel alloc] initWithFrame:CGRectMake(marigin, totalLbl.frame.origin.y + totalLbl.frame.size.height + 10, 100, 20)];
        periodLbl.text = @"周期：6个月";
        periodLbl.textColor = TextMidGray;
        periodLbl.font = FontSmall;
        [midBgView addSubview:periodLbl];
        
        //票房
        UILabel *boLbl = [[UILabel alloc] initWithFrame:CGRectMake(periodLbl.frame.size.width + marigin*2, totalLbl.frame.origin.y + totalLbl.frame.size.height + 10, 100, 20)];
        boLbl.text = @"票房1.8亿";
        boLbl.textColor = TextMidGray;
        boLbl.font = FontSmall;
        [midBgView addSubview:boLbl];
        
        
        //回报率
        UILabel *returnLbl = [[UILabel alloc] initWithFrame:CGRectMake(marigin, periodLbl.frame.origin.y + periodLbl.frame.size.height + 10, 100, 20)];
        returnLbl.attributedText = [ZZWTool getAttributeStrWithFrontStr:@"回报率：" frontColor:TextMidGray behindStr:@"125%" behindColor:TextRed];
        returnLbl.font = FontSmall;
        [midBgView addSubview:returnLbl];
        
        UIImageView *markImageV = [[UIImageView alloc] initWithFrame:CGRectMake(midBgView.frame.size.width - 53, midBgView.frame.size.height - 50, 53, 50)];
        markImageV.image = [UIImage imageNamed:@"first_赚钱了"];
        [midBgView addSubview:markImageV];
        
        [topBgView addSubview:midBgView];
    }
    
    
    

    
    originY += 160;
    UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, originY, ScreenWidth, 44)];
    [view addSubview:head];
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(marigin, 10, ScreenWidth/2, 20)];
    titleLbl.text = @"演员人员";
    [head addSubview:titleLbl];
    
//    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [rightBtn setTitle:@"全部" forState:UIControlStateNormal];
//    [rightBtn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
//    [rightBtn setImage:[UIImage imageNamed:@"mall_right"] forState:UIControlStateNormal];
//    rightBtn.frame = CGRectMake(ScreenWidth - DefaultMargin - 100, 0, 100, 44);
//    [rightBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleRight imageTitleSpace:5];
//    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    [head addSubview:rightBtn];
    
//    UILabel *allLbl = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth - 100 -16, 10, 100, 20)];
//    allLbl.text = @"全部";
//    allLbl.textAlignment = NSTextAlignmentRight;
//    [head addSubview:allLbl];
    
    originY += 44;
    
//    originY = line.frame.size.height + line.frame.origin.y;
//    _adImges = @[@"shenteng",@"shenteng",@"shenteng",@"shenteng"];
    ActorModel *model = _actorModelArr.firstObject;
    image = [UIImage imageNamed:model.actorImage];
    CGSize size = CGSizeMake(54, 75);
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;//垂直流布局
    layout.headerReferenceSize = CGSizeMake(10, size.height*2 + 40);
    layout.footerReferenceSize = CGSizeMake(10, size.height*2 + 40);
    layout.itemSize = CGSizeMake(size.width*2, size.height*2 + 40);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 1;
    UICollectionView *collect = [[UICollectionView alloc] initWithFrame:CGRectMake(0, originY, ScreenWidth, size.height*2 + 40) collectionViewLayout:layout];
    collect.backgroundColor = [UIColor whiteColor];
    collect.delegate = self;
    collect.dataSource = self;
    collect.showsHorizontalScrollIndicator = NO;//隐藏水平滚动条
    [collect registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    [view addSubview:collect];
    //    self.view.backgroundColor = [UIColor whiteColor];
    
    originY = originY + size.height*2 + 40;
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, originY, ScreenWidth, 10)];
    line2.backgroundColor = ProgressBgGray;
    [view addSubview:line2];
    
    view.frame = CGRectMake(0, 0, ScreenWidth, originY + 15);
    return view;
}

#pragma mark Button Action

-(void)rightItemPress:(UIButton *)button{
    if (button.tag == 100) {
    }
    
}
-(void)sellTickets:(UIButton *)button{
    if (button.tag == 100) {
    }
    
}
-(void)sellGoods:(UIButton *)button{
    if (button.tag == 100) {
    }
    
}
-(void)buttonAction:(UIButton *)button{
    button.selected = !button.selected;
    if (button.tag == 100) {
        UILabel *label = [self.view viewWithTag:button.tag + 100];
        NSInteger count = [label.text integerValue];
        if (button.selected) {
            [button setBackgroundImage:[UIImage imageNamed:@"icon_dianzan_xz"] forState:UIControlStateNormal];
            count ++;
            label.text = [NSString stringWithFormat:@"%ld",count];
        }else{
            [button setBackgroundImage:[UIImage imageNamed:@"icon_dianzan"] forState:UIControlStateNormal];
            count --;
            label.text = [NSString stringWithFormat:@"%ld",count];
        }
    }else if (button.tag == 101){
        UILabel *label = [self.view viewWithTag:button.tag + 100];
        NSInteger count = [label.text integerValue];
        if (button.selected) {
            [button setBackgroundImage:[UIImage imageNamed:@"icon_guanz_xz"] forState:UIControlStateNormal];
            count ++;
            label.text = [NSString stringWithFormat:@"%ld",count];
        }else{
            [button setBackgroundImage:[UIImage imageNamed:@"icon_guanz"] forState:UIControlStateNormal];
            count --;
            label.text = [NSString stringWithFormat:@"%ld",count];
            
        }
        
    }else if (button.tag == 102){
        CustomerServiceViewController *vc = [CustomerServiceViewController new];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}


- (IBAction)investAction:(id)sender {
//    NSArray *titles = @[self.filmName];
//    NSArray *arr2 = [[ZZWDataSaver shareManager] queryFilmInfosWithFilmNames:titles.copy];
//    NSArray *arr  = [[ZZWDataSaver shareManager] queryFilmDetailWithFilmName:self.filmName];
//    NSLog(@"%@");
    
    InvestViewController *vc = [InvestViewController new];
    vc.filmName = self.filmName;
    vc.filmModel = self.filmModel;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)moniAction:(id)sender {
    EarningsReportViewController *vc = [EarningsReportViewController new];
    vc.filmModel = self.filmModel;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)setHiddenInvestBtn:(BOOL)hiddenInvestBtn{
    _hiddenInvestBtn = hiddenInvestBtn;
    if (hiddenInvestBtn) {
        self.investBtn.backgroundColor = ButtonBg_gray;
        self.investBtn.userInteractionEnabled = NO;
    }else{
        self.investBtn.backgroundColor = ButtonBg_red;
        self.investBtn.userInteractionEnabled = YES;
    }
}
#pragma mark collection
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _actorModelArr.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    
    ActorModel *model = _actorModelArr[indexPath.item];
    UIImage *image = [UIImage imageNamed:model.actorImage];
//    CGSize size = image.size;
    CGSize size = CGSizeMake(54, 75);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width*2, size.height*2)];
    imageView.image = image;
    [cell.contentView addSubview:imageView];
    
    UILabel *roleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, size.height*2, size.width*2, 20)];
    roleLbl.textAlignment = NSTextAlignmentCenter;
    NSString *text = @"";
    if (model.actorType == 1) {
        text = @"导演";
    }else if(model.actorType == 2){
        text = @"演员";
    }else{
        text = @"编剧";
    }
    roleLbl.font = FontSmall;
    roleLbl.text = text;
    [cell.contentView addSubview:roleLbl];
    
    UILabel *nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, size.height*2 + 20, size.width*2, 20)];
    nameLbl.text = model.actorName;
    nameLbl.font = FontDefault;
    nameLbl.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:nameLbl];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [super showHudWithType:NotOpen];
}

#pragma mark Table
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(DefaultMargin, 10, ScreenWidth -DefaultMargin*2, 20)];
    [view addSubview:label];
    if (section == 0) {
        label.textAlignment = NSTextAlignmentLeft;
        label.text = @"项目简介";
    }else{
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"剧情简介";
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth/2 - 50/2, 30, 50, 3)];
        line.backgroundColor = [UIColor redColor];
        [view addSubview:line];
    }
    return view;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //计算出文字内容高度，计算出图片高度
    
    NSString *content = @"“囧”系列巨作，延续 大热IP,引爆观影热潮。一线实力派明星出演，续写票房神话。";
    if (self.model.proejectBrief != nil) {
        if (indexPath.section == 0) {
            content = self.model.proejectBrief;
        }else{
            content = self.model.synopsis;
        }
    }
    
    CGFloat height = [ZZWTool getHeightWithFont:[UIFont systemFontOfSize:14] width:ScreenWidth-16*2 content:content];
    UIImage * image = [UIImage imageNamed:@"banner-1"];
    if (self.model.proejectBrief != nil) {
        image = [UIImage imageNamed:[self.model.synopsisImages componentsSeparatedByString:@"&"][indexPath.section]];
    }
    
    CGFloat height2 = (image.size.height/image.size.width)*ScreenWidth;
    return height + height2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FilmInfoCell *cell = [[FilmInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
   
    if (self.model != nil) {
        if (indexPath.section == 0) {
            cell.content = self.model.proejectBrief;
        }else{
            cell.content = self.model.synopsis;
        }
        cell.image = [UIImage imageNamed:[self.model.synopsisImages componentsSeparatedByString:@"&"][indexPath.section]];
    }else{
        cell.content = @"“囧”系列巨作，延续 大热IP,引爆观影热潮。一线实力派明星出演，续写票房神话。";
        cell.image = [UIImage imageNamed:@"banner-1"];
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end
