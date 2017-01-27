//
//  HowToBuyViewController.m
//  AstaGuru
//
//  Created by sumit mashalkar on 21/10/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "HowToBuyViewController.h"
#import "ClsHowToBuy.h"
#import "HeaderView.h"
#import "clsAboutUs.h"
#import "VideoViewInHowToBuy.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"
#import "ClsSetting.h"
#import "TTTAttributedLabel.h"
#import "ClientRelationViewController.h"

@interface HowToBuyViewController ()<YTPlayerViewDelegate, UIActionSheetDelegate, TTTAttributedLabelDelegate>
{
    NSMutableArray *arrdata;
    NSMutableArray *arrHeaderview;
    NSMutableArray *arrVAcncyTitleOnly;

}
@end

@implementation HowToBuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arrHeaderview=[[NSMutableArray alloc]init];
    if (_isHowTobuy==1)
    {
       [self Setup];
    }
   else if (_isHowTobuy==3)
    {
        [self SetupServices];
    }
   else if (_isHowTobuy==4)
   {
       [self SetupTermsCondition];
   }
   else if (_isHowTobuy==5)
   {
       [self vacancy];
   }
    
    else
    {
        [self setupHowtosell];
    }
    [self setUpNavigationItem];
    _tblHowtoBuy.arrData=arrdata;
    
    self.tblHowtoBuy.estimatedRowHeight = 100.0;
    self.tblHowtoBuy.rowHeight = UITableViewAutomaticDimension;
    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
 [_tblHowtoBuy openSection:0 animated:NO];
    [_tblHowtoBuy closeSection:0 animated:NO];
}
-(void)setUpNavigationItem
{
    self.sidebarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"signs"] style:UIBarButtonItemStyleDone target:self.revealViewController action:@selector(revealToggle:)];
    self.sidebarButton.tintColor=[UIColor whiteColor];
    if (_isHowTobuy==1)
    {
        self.navigationItem.title=@"How To Buy";
    }
   else if (_isHowTobuy==3)
    {
        self.navigationItem.title=@"Services";
    }
   else if (_isHowTobuy==4)
   {
       self.navigationItem.title=@"Terms & Conditions";
   }
   else if (_isHowTobuy==5)
   {
//       self.navigationItem.title=@"Careers";
   }
   else
   {
       self.navigationItem.title=@"How To Sell";
   }
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[self navigationItem] setLeftBarButtonItem:self.sidebarButton];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.revealViewController setFrontViewController:self.navigationController];
    [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"WorkSans-Medium" size:17]}];
    
    self.sideleftbarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-close"] style:UIBarButtonItemStyleDone target:self action:@selector(closePressed)];
    self.sideleftbarButton.tintColor=[UIColor whiteColor];
    [[self navigationItem] setRightBarButtonItem:self.sideleftbarButton];
}

-(void)SetupServices
{
    arrdata=[[NSMutableArray alloc]init];
    
    
    ClsHowToBuy *objhowtoBuy=[[ClsHowToBuy alloc]init];
    objhowtoBuy.arrSubarray=[[NSMutableArray alloc] init];
    objhowtoBuy.Titlel=@"Auction";
    
    NSString *str1=@"Established in the year 2008 AstaGuru, India's premium online auction house caters to a global clientele by conducting auctions for Modern & Contemporary Indian Art and have diversified over the period of time and curate auctions for Collectibles & Antiques as well. With an overall art management experience spanning over three decades we have amalgamated all our industry related knowledge and have molded it to function on a digital structure.";
    clsAboutUs *objAboutUS=[[clsAboutUs alloc]init];
    objAboutUS.strName=str1;
    objAboutUS.strType=@"3";
    [objhowtoBuy.arrSubarray addObject:objAboutUS];
   
    
    
    NSString *str11=@"With the world becoming one big market place we provide a safe and secure platform ensuring the ambitions of art collectors are achieved. With a well trained and highly efficient team, artworks & collectible antiques are filtered and only the best creations are part of our auctions. Art is always born with a soul and it is our prerogative to safeguard its sanctity.";
    clsAboutUs *objAboutUS1=[[clsAboutUs alloc]init];
    objAboutUS1.strName=str11;
    objAboutUS1.strType=@"3";
    [objhowtoBuy.arrSubarray addObject:objAboutUS1];
    [arrdata addObject:objhowtoBuy];
    
    
    
    
    ClsHowToBuy *objhowtoBuy1=[[ClsHowToBuy alloc]init];
    objhowtoBuy1.Titlel=@"Consultation";
    objhowtoBuy1.arrSubarray=[[NSMutableArray alloc] init];
    
    NSString *str111=@"Knowledge translates into wisdom when shared, therefore our doors are always open for individuals who are keen about enriching their lives through art. Our knowledge and industry experience equips us to guide you with regards to your art & collectibles related conundrums, based on your preferences and needs we help you understand which artwork will best suit your senses or which artifact will blend in with your commercial or residential space. ";
    clsAboutUs *objAboutUS11=[[clsAboutUs alloc]init];
    objAboutUS11.strName=str111;
    objAboutUS11.strType=@"3";
    [objhowtoBuy1.arrSubarray addObject:objAboutUS11];
    NSString *str12=@"Our guiding force, Mr Vickram Sethi is an art connoisseur and has been associated with the world of art for over three decades. His valued insights are crucial, he not only takes into account the provenance but also has developed a keen eye to deduce and ascertain works with immense potential and seminal attributes. Art gets intertwined within the home it dwells in and its owner, we take pride in consulting and presiding this communion of joy.";
    clsAboutUs *objAboutUS12=[[clsAboutUs alloc]init];
    objAboutUS12.strName=str12;
    objAboutUS12.strType=@"3";
    [objhowtoBuy1.arrSubarray addObject:objAboutUS12];
    [arrdata addObject:objhowtoBuy1];
    
    
    
    
    ClsHowToBuy *objhowtoBuy2=[[ClsHowToBuy alloc]init];
    objhowtoBuy2.arrSubarray=[[NSMutableArray alloc] init];
    objhowtoBuy2.Titlel=@"Restoration";
    
    NSString *str21=@"Restoration is best left to the experts, considering this service entails the longevity of the artwork. Exposure to direct sunlight or moisture are deterrents and do not facilitate a conducive environment for storage and showcasing artworks of various mediums.";
    clsAboutUs *objAboutUS21=[[clsAboutUs alloc]init];
    objAboutUS21.strName=[NSString stringWithFormat:@"%@",str21];
    objAboutUS21.strType=@"3";
    [objhowtoBuy2.arrSubarray addObject:objAboutUS21];
    
    NSString *str22=@"We therefore undertake restoration operations not only to salvage an artwork which may be tampered but also in order to give it a protective shield. Work of such delicacy is entrusted to our high skilled restoration team, so you can be at complete peace of mind when your possession is in our care.";
    clsAboutUs *objAboutUS22=[[clsAboutUs alloc]init];
    objAboutUS22.strName=[NSString stringWithFormat:@"%@",str22];
    objAboutUS22.strType=@"3";
    [objhowtoBuy2.arrSubarray addObject:objAboutUS22];
    
    [arrdata addObject:objhowtoBuy2];
    
    
    
    ClsHowToBuy *objhowtoBuy3=[[ClsHowToBuy alloc]init];
    objhowtoBuy3.arrSubarray=[[NSMutableArray alloc] init];
    objhowtoBuy3.Titlel=@"Valuation";
    
    NSString *str31=@"Various parameters such as provenance, medium, period, subject, whether the artwork has been published and the overall condition, influence the value of the art work or collectibles. Since it is a niche market the advice and inputs from market experts are imperative to ascertain the true value of the creation.";
    clsAboutUs *objAboutUS31=[[clsAboutUs alloc]init];
    objAboutUS31.strName=[NSString stringWithFormat:@"%@",str31];
    objAboutUS31.strType=@"3";
    [objhowtoBuy3.arrSubarray addObject:objAboutUS31];
    
    NSString *str32=@"At AstaGuru, we have a stringent process in place, research and investigation done by our team looks into all the impactful aspects, be it a piece of art ranging from canvas to paper or artifacts such as rare pens & exquisite timepieces. Once the condition and authenticity is looked into, its value is determined. Through the course of our journey we have horned our skills, combined with a structurally sound and real time process, we conduct an in depth analysis of the artwork or collectible before calculating its value.";
    clsAboutUs *objAboutUS32=[[clsAboutUs alloc]init];
    objAboutUS32.strName=[NSString stringWithFormat:@"%@",str32];
    objAboutUS32.strType=@"3";
    [objhowtoBuy3.arrSubarray addObject:objAboutUS32];
    
    [arrdata addObject:objhowtoBuy3];
    
    
}
-(void)SetupTermsCondition
{
    arrdata=[[NSMutableArray alloc]init];
    
    
    ClsHowToBuy *objhowtoBuy=[[ClsHowToBuy alloc]init];
    objhowtoBuy.arrSubarray=[[NSMutableArray alloc] init];
    objhowtoBuy.Titlel=@"General Terms";
    
    clsAboutUs *objclsAboutus1=[[clsAboutUs alloc]init];
    objclsAboutus1.strName=@"By participating in this auction, you acknowledge that you are bound by the Conditions for Sale listed below and on the website www.astaguru.com\n";
    objclsAboutus1.strType=@"3";
    [objhowtoBuy.arrSubarray addObject:objclsAboutus1];
    clsAboutUs *objclsAboutus2=[[clsAboutUs alloc]init];
    objclsAboutus2.strName=@"Making a Winning Bid results in an enforceable contract of sale.";
    objclsAboutus2.strType=@"1";
    [objhowtoBuy.arrSubarray addObject:objclsAboutus2];
    
    clsAboutUs *objclsAboutus3=[[clsAboutUs alloc]init];
    objclsAboutus3.strName=@"AstaGuru is authorized by the seller to display at AstaGuru's discretion images and description of all lots in the catalogue and on the website.";
    objclsAboutus3.strType=@"1";
    [objhowtoBuy.arrSubarray addObject:objclsAboutus3];
    clsAboutUs *objclsAboutus4=[[clsAboutUs alloc]init];
    objclsAboutus4.strName=@"AstaGuru can grant record and reject any bids.";
    objclsAboutus4.strType=@"1";
    [objhowtoBuy.arrSubarray addObject:objclsAboutus4];
    
    
    clsAboutUs *objclsAboutus5=[[clsAboutUs alloc]init];
    objclsAboutus5.strName=@"Bidding access shall be given on AstaGuru's discretion . AstaGuru may ask for a deposit on lots prior to giving bidding access.";
    objclsAboutus5.strType=@"1";
    [objhowtoBuy.arrSubarray addObject:objclsAboutus5];
    
    clsAboutUs *objclsAboutus6=[[clsAboutUs alloc]init];
    objclsAboutus6.strName=@"AstaGuru may review bid histories of specific lots periodically to preserve the efficacy of the auction process.";
    objclsAboutus6.strType=@"1";
    [objhowtoBuy.arrSubarray addObject:objclsAboutus6];
    
    clsAboutUs *objclsAboutus7=[[clsAboutUs alloc]init];
    objclsAboutus7.strName=@"AstaGuru has the right to withdraw a Property before, during or after the bidding, if it has reason to believe that the authenticity of the Property or accuracy of description is in doubt.";
    objclsAboutus7.strType=@"1";
    [objhowtoBuy.arrSubarray addObject:objclsAboutus7];
    
    clsAboutUs *objclsAboutus8=[[clsAboutUs alloc]init];
    objclsAboutus8.strName=@"All proprieties shall be sold only if the reserve price in met. Reserve price is on each Property is confidential and shall not be disclosed . AstaGuru shall raise all invoices including buyers premium and related taxes.";
    objclsAboutus8.strType=@"1";
    [objhowtoBuy.arrSubarray addObject:objclsAboutus8];
    
    
    clsAboutUs *objclsAboutus9=[[clsAboutUs alloc]init];
    objclsAboutus9.strName=@"The Buyers Premium shall be calculated at 15% of the hammer price.";
    objclsAboutus9.strType=@"1";
    [objhowtoBuy.arrSubarray addObject:objclsAboutus9];
    
    clsAboutUs *objclsAboutus10=[[clsAboutUs alloc]init];
    objclsAboutus10.strName=@"All foreign currency exchange rates during the Auction are made on a constant of 1:60 (USD:INR) . All invoicing details shall be provided by the buyer prior to the auction.";
    objclsAboutus10.strType=@"1";
    [objhowtoBuy.arrSubarray addObject:objclsAboutus10];
    
    
    clsAboutUs *objclsAboutus11=[[clsAboutUs alloc]init];
    objclsAboutus11.strName=@"All payments shall be made within 7 days from the date of the invoice.";
    objclsAboutus11.strType=@"1";
    [objhowtoBuy.arrSubarray addObject:objclsAboutus11];
    
    clsAboutUs *objclsAboutus12=[[clsAboutUs alloc]init];
    objclsAboutus12.strName=@"In case payment is not made within the stated time period, it shall be treated as a breach of contract and the Seller may authorise AstaGuru to take any steps (including the institution of legal proceedings).";
    objclsAboutus12.strType=@"1";
    [objhowtoBuy.arrSubarray addObject:objclsAboutus12];
    
    clsAboutUs *objclsAboutus13=[[clsAboutUs alloc]init];
    objclsAboutus13.strName=@"AstaGuru may charge a 2% late payment fine per month. . If the buyer wishes to collect the property from AstaGuru, it must be collected within 30 Days from the date of the auction. The buyer shall be charged a 2% storage fee if the property is not collected.";
    objclsAboutus13.strType=@"1";
    [objhowtoBuy.arrSubarray addObject:objclsAboutus13];
    
    clsAboutUs *objclsAboutus14=[[clsAboutUs alloc]init];
    objclsAboutus14.strName=@"AstaGuru reserves the right not to award the Winning Bid to the Bidder with the highest Bid at Closing Date if it deems it necessary to do so. . In an unlikely event of any technical failure and the website is inaccessible. The lot closing time shall be extended.";
    objclsAboutus14.strType=@"1";
    [objhowtoBuy.arrSubarray addObject:objclsAboutus14];
    
    clsAboutUs *objclsAboutus15=[[clsAboutUs alloc]init];
    objclsAboutus15.strName=@"Bids recorded prior to the technical problem shall stand valid according to the terms of sale.";
    objclsAboutus15.strType=@"1";
    [objhowtoBuy.arrSubarray addObject:objclsAboutus15];
    [arrdata addObject:objhowtoBuy];
    
    
    
    
    ClsHowToBuy *objhowtoBuy1=[[ClsHowToBuy alloc]init];
    objhowtoBuy1.Titlel=@"Authenticity Guarantee";
    objhowtoBuy1.arrSubarray=[[NSMutableArray alloc] init];
    
    clsAboutUs *objclsAboutus16=[[clsAboutUs alloc]init];
    objclsAboutus16.strName=@"AstaGuru assures on behalf of the seller that all properties on the website are genuine work of the artist listed.";
    objclsAboutus16.strType=@"1";
    [objhowtoBuy1.arrSubarray addObject:objclsAboutus16];
    
    clsAboutUs *objclsAboutus17=[[clsAboutUs alloc]init];
    objclsAboutus17.strName=@"How ever in an unlikely event if the property is proved to be inauthentic to AstaGuru's satisfaction within a period of 6 months from the collection date. The seller shall be liable to pay back the full amount to the buyer. These claims will be handled on a case-by-case basis, and will require that examinable proof which clearly demonstrates that the Property is inauthentic is provided by an established and acknowledged authority. Only the actual Buyer (as registered with AstaGuru) makes the claim.";
    objclsAboutus17.strType=@"1";
    [objhowtoBuy1.arrSubarray addObject:objclsAboutus17];
    
    clsAboutUs *objclsAboutus18=[[clsAboutUs alloc]init];
    objclsAboutus18.strName=@"The property, when returned, should be in the same condition as when it was purchased.";
    objclsAboutus18.strType=@"1";
    [objhowtoBuy1.arrSubarray addObject:objclsAboutus18];
    
    clsAboutUs *objclsAboutus19=[[clsAboutUs alloc]init];
    objclsAboutus19.strName=@"In case the Buyer request for a certificate of authentication for a particular artwork, Astaguru will levy the expenditure of the same onto the Buyer.";
    objclsAboutus19.strType=@"1";
    [objhowtoBuy1.arrSubarray addObject:objclsAboutus19];
    
    clsAboutUs *objclsAboutus20=[[clsAboutUs alloc]init];
    objclsAboutus20.strName=@"AstaGuru shall charge the buyer in case any steps are to be taken for special expenses shall take place in order to prove the authenticity of the property.";
    objclsAboutus20.strType=@"1";
    [objhowtoBuy1.arrSubarray addObject:objclsAboutus20];
    
    clsAboutUs *objclsAboutus21=[[clsAboutUs alloc]init];
    objclsAboutus21.strName=@"In case the seller fails to refund the funds. Astaguru shall be authorized by the buyer to take legal action on behalf of the buyer to recover the money at the expense of the buyer.";
    objclsAboutus21.strType=@"1";
    [objhowtoBuy1.arrSubarray addObject:objclsAboutus21];
    [arrdata addObject:objhowtoBuy1];
    
    
    
    
    ClsHowToBuy *objhowtoBuy2=[[ClsHowToBuy alloc]init];
    objhowtoBuy2.arrSubarray=[[NSMutableArray alloc] init];
    objhowtoBuy2.Titlel=@"Extent of AstaGuru's Liability";
    
    clsAboutUs *objclsAboutus22=[[clsAboutUs alloc]init];
    objclsAboutus22.strName=@"AstaGuru will obtain the money from the seller and thereafter refund to the buyer the amount of purchase in case the work is not authentic.";
    objclsAboutus22.strType=@"1";
    [objhowtoBuy2.arrSubarray addObject:objclsAboutus22];
    
    clsAboutUs *objclsAboutus23=[[clsAboutUs alloc]init];
    objclsAboutus23.strName=@"All damages and loss during transit are covered by the insurance policy, AstaGuru is not liable.";
    objclsAboutus23.strType=@"1";
    [objhowtoBuy2.arrSubarray addObject:objclsAboutus23];
    clsAboutUs *objclsAboutus24=[[clsAboutUs alloc]init];
    objclsAboutus24.strName=@"AstaGuru or any member of its team is not liable for any mistakes made in the catalogue.";
    objclsAboutus24.strType=@"1";
    [objhowtoBuy2.arrSubarray addObject:objclsAboutus24];
    clsAboutUs *objclsAboutus25=[[clsAboutUs alloc]init];
    objclsAboutus25.strName=@"AstaGuru is not liable for any claims in insurance.";
    objclsAboutus25.strType=@"1";
    [objhowtoBuy2.arrSubarray addObject:objclsAboutus25];
    
    clsAboutUs *objclsAboutus26=[[clsAboutUs alloc]init];
    objclsAboutus26.strName=@"AstaGuru is not liable in case the website has any technical problems.";
    objclsAboutus26.strType=@"1";
    [objhowtoBuy2.arrSubarray addObject:objclsAboutus26];
    clsAboutUs *objclsAboutus27=[[clsAboutUs alloc]init];
    objclsAboutus27.strName=@"If any part of the Conditions for Sale between the Buyer and AstaGuru is found by any court to be invalid, illegal or unenforceable, that part may be discounted and the rest of the conditions shall be enforceable to the fullest extent permissible by law.";
    objclsAboutus27.strType=@"1";
    [objhowtoBuy2.arrSubarray addObject:objclsAboutus27];
    [arrdata addObject:objhowtoBuy2];
    
    ClsHowToBuy *objhowtoBuy3=[[ClsHowToBuy alloc]init];
    objhowtoBuy3.arrSubarray=[[NSMutableArray alloc] init];
    objhowtoBuy3.Titlel=@"Law and Jurisdiction";
    
    clsAboutUs *objclsAboutus28=[[clsAboutUs alloc]init];
    objclsAboutus28.strName=@"The terms and conditions of this Auction are subject to the laws of India, which will apply to the construction and to the effect of the clauses. All parties are subject to the exclusive jurisdiction of the courts at Mumbai, Maharashtra, India.";
    objclsAboutus28.strType=@"3";
    [objhowtoBuy3.arrSubarray addObject:objclsAboutus28];
    [arrdata addObject:objhowtoBuy3];
    
    
}


-(void)setupHowtosell
{
   
        arrdata=[[NSMutableArray alloc]init];
    
    
        ClsHowToBuy *objhowtoBuy=[[ClsHowToBuy alloc]init];
        objhowtoBuy.arrSubarray=[[NSMutableArray alloc] init];
        objhowtoBuy.Titlel=@"Evaluation";
    
        NSString *str1=@"The first step in the process is to arrange a consultation with one of our representatives. You can contact us or email us with details of your property. We shall then study the property and give you a valuation on the same. We will respond to your auction estimate request within 3 working days. It is very important to AstaGuru to provide the highest level of service; accordingly, we cannot rush valuations.";
        clsAboutUs *objAboutUS=[[clsAboutUs alloc]init];
        objAboutUS.strName=str1;
        objAboutUS.strType=@"1";
        [objhowtoBuy.arrSubarray addObject:objAboutUS];
        [arrdata addObject:objhowtoBuy];
        
        
        
        
        ClsHowToBuy *objhowtoBuy1=[[ClsHowToBuy alloc]init];
        objhowtoBuy1.Titlel=@"Decision to sell";
        objhowtoBuy1.arrSubarray=[[NSMutableArray alloc] init];
        
        NSString *str11=@"Based on the valuation result, you and AstaGuru' s experts will decide whether your property is appropriate for sale at auction. We will also recommend an appropriate venue and possible sale timing. If you decide to proceed, you will sign a contract, and AstaGuru will take the property in for cataloguing and photography. ";
        clsAboutUs *objAboutUS11=[[clsAboutUs alloc]init];
        objAboutUS11.strName=str11;
        objAboutUS11.strType=@"1";
        [objhowtoBuy1.arrSubarray addObject:objAboutUS11];
        [arrdata addObject:objhowtoBuy1];
        
        
        
        
        ClsHowToBuy *objhowtoBuy2=[[ClsHowToBuy alloc]init];
        objhowtoBuy2.arrSubarray=[[NSMutableArray alloc] init];
        objhowtoBuy2.Titlel=@"logistics";
        
        NSString *str21=@"Our Art Transport or Shipping Department can help you arrange to have your property delivered to our offices, if necessary. As the consignor, you are responsible for packing, shipping and insurance charges.";
        clsAboutUs *objAboutUS21=[[clsAboutUs alloc]init];
        objAboutUS21.strName=[NSString stringWithFormat:@"%@",str21];
        objAboutUS21.strType=@"1";
        [objhowtoBuy2.arrSubarray addObject:objAboutUS21];
        [arrdata addObject:objhowtoBuy2];
        
        
        
        
        ClsHowToBuy *objhowtoBuy3=[[ClsHowToBuy alloc]init];
        objhowtoBuy3.Titlel=@"Reserve Price";
        NSString *str31=@"The reserve is the confidential minimum selling price to which a consignor (you) and AstaGuru agree before the sale - your property's 'floor' price, below which no bid will be accepted. If bidding on your item fails to reach the reserve, we will not sell the piece and will advise you of your options. It is important to consider the reserve price in light of the fact that AstaGuru will assess fees and handling costs for unsold lots. ";
        objhowtoBuy3.arrSubarray=[[NSMutableArray alloc] init];
        clsAboutUs *objAboutUS31=[[clsAboutUs alloc]init];
        objAboutUS31.strName=str31;
        objAboutUS31.strType=@"1";
        [objhowtoBuy3.arrSubarray addObject:objAboutUS31];
        [arrdata addObject:objhowtoBuy3];
        
        ClsHowToBuy *objhowtoBuy4=[[ClsHowToBuy alloc]init];
        objhowtoBuy4.arrSubarray=[[NSMutableArray alloc] init];
        objhowtoBuy4.Titlel=@"Seller’s Contract";
        NSString *str41=@"The seller contract covers two important issues that will affect your bottom line: the reserve price and AstaGuru's commissions.";
        clsAboutUs *objAboutUS41=[[clsAboutUs alloc]init];
        objAboutUS41.strName=str41;
        objAboutUS41.strType=@"1";
        [objhowtoBuy4.arrSubarray addObject:objAboutUS41];
    
        NSString *str42=@"Reserve price.";
        clsAboutUs *objAboutUS42=[[clsAboutUs alloc]init];
        objAboutUS42.strName=str42;
        objAboutUS42.strType=@"2";
        [objhowtoBuy4.arrSubarray addObject:objAboutUS42];
    
    
    clsAboutUs *objAboutUS43=[[clsAboutUs alloc]init];
    objAboutUS43.strName=@"The reserve is the confidential minimum selling price to which a consignor (you) and AstaGuru agree before the sale - your property's 'floor' price, below which no bid will be accepted. If bidding on your item fails to reach the reserve, we will not sell the piece and will advise you of your options. It is important to consider the reserve price in light of the fact that AstaGuru will assess fees and handling costs for unsold lots. ";
    objAboutUS43.strType=@"1";
    [objhowtoBuy4.arrSubarray addObject:objAboutUS43];
    
    
    clsAboutUs *objAboutUS44=[[clsAboutUs alloc]init];
    objAboutUS44.strName=@"Seller's commission.";
    objAboutUS44.strType=@"2";
    [objhowtoBuy4.arrSubarray addObject:objAboutUS44];
    
  
    clsAboutUs *objAboutUS45=[[clsAboutUs alloc]init];
    objAboutUS45.strName=@"Sellers pay a commission that is deducted, along with any agreed-upon expenses, from the hammer price. Should you have any specific questions regarding the selling commission, please call the appropriate representative for more information.";
    objAboutUS45.strType=@"1";
    [objhowtoBuy4.arrSubarray addObject:objAboutUS45];
    [arrdata addObject:objhowtoBuy4];
    
    
        ClsHowToBuy *objhowtoBuy5=[[ClsHowToBuy alloc]init];
        objhowtoBuy5.Titlel=@"Payment";
        NSString *str51=@"Shortly after the sale, you will receive a listing of the final hammer price for each item you consigned. We will issue the payment within 40 days from the day of the sale provided we are in receipt of the buyer's payment.  ";
        objhowtoBuy5.arrSubarray=[[NSMutableArray alloc] init];
        clsAboutUs *objAboutUS51=[[clsAboutUs alloc]init];
        objAboutUS51.strName=str51;
        objAboutUS51.strType=@"1";
        [objhowtoBuy5.arrSubarray addObject:objAboutUS51];
       [arrdata addObject:objhowtoBuy5];
    
        
}
-(void)vacancy
{
    
    @try {
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.labelText = @"loading";
        
        NSMutableDictionary *Discparam=[[NSMutableDictionary alloc]init];
        // [Discparam setValue:@"cr2016" forKey:@"validate"];
        //[Discparam setValue:@"banner" forKey:@"action"];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];  //AFHTTPResponseSerializer serializer
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        ClsSetting *objsetting=[[ClsSetting alloc]init];
        NSString  *strQuery=[NSString stringWithFormat:@"%@jobs?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed",[objsetting Url]];
        NSString *url = strQuery;
        NSLog(@"%@",url);
        NSString *encoded = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [manager GET:encoded parameters:Discparam success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             //  NSError *error=nil;
//             NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];

             NSError *error;
             NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
             // NSLog(@"%@",responseStr);
             // NSLog(@"%@",dict);
             NSMutableArray *arrItemCount=[[NSMutableArray alloc]init];
             arrVAcncyTitleOnly=[[NSMutableArray alloc]init];
             arrItemCount=[parese parsevacancy:[dict valueForKey:@"resource"]];
             
             arrVAcncyTitleOnly=[parese parsevacancyTitle:[dict valueForKey:@"resource"]];;

              arrdata=[[NSMutableArray alloc]init];
             arrdata=arrItemCount;
             [_tblHowtoBuy reloadData];
             [HUD hide:YES];
             
         }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 NSLog(@"Error: %@", error);
                 [ClsSetting ValidationPromt:error.localizedDescription];
//                 if ([operation.response statusCode]==404)
//                 {
//                     [ClsSetting ValidationPromt:@"No Record Found"];
//                     
//                 }
//                 else
//                 {
//                     [ClsSetting internetConnectionPromt];
//                     
//                 }
                 [HUD hide:YES];

             }];
        
        
    }
    @catch (NSException *exception)
    {
        
    }
    @finally
    {
    }
}
-(void)closePressed
{
    if (_isHowTobuy==5)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
    {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SWRevealViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
    UIViewController *viewController =rootViewController;
    AppDelegate * objApp = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    objApp.window.rootViewController = viewController;
    }
}
-(void)Setup
{
    arrdata=[[NSMutableArray alloc]init];
   
    
    ClsHowToBuy *objhowtoBuy=[[ClsHowToBuy alloc]init];
    objhowtoBuy.arrSubarray=[[NSMutableArray alloc] init];
    objhowtoBuy.Titlel=@"Estimates";
    
    NSString *str1=@"Estimates are based on an average market value of the lot.";
    clsAboutUs *objAboutUS=[[clsAboutUs alloc]init];
    objAboutUS.strName=str1;
    objAboutUS.strType=@"1";
    [objhowtoBuy.arrSubarray addObject:objAboutUS];
    
    
    NSString *str2=@"These are provided only as a guide for buyers.";
    clsAboutUs *objAboutUS2=[[clsAboutUs alloc]init];
    objAboutUS2.strName=str2;
    objAboutUS2.strType=@"1";
    [objhowtoBuy.arrSubarray addObject:objAboutUS2];
    
    
    
    NSString *str3=@"Buyers should not rely on estimates as a prediction of actual price.";
    clsAboutUs *objAboutUS3=[[clsAboutUs alloc]init];
    objAboutUS3.strName=str3;
    objAboutUS3.strType=@"1";
    [objhowtoBuy.arrSubarray addObject:objAboutUS3];
    
    NSString *str4=@"Estimates do not include Buyers Premium.";
    clsAboutUs *objAboutUS4=[[clsAboutUs alloc]init];
    objAboutUS4.strName=str4;
    objAboutUS4.strType=@"1";
    [objhowtoBuy.arrSubarray addObject:objAboutUS4];
    
    [arrdata addObject:objhowtoBuy];
    
    
    
    
    ClsHowToBuy *objhowtoBuy1=[[ClsHowToBuy alloc]init];
    objhowtoBuy1.Titlel=@"Reserves";
    objhowtoBuy1.arrSubarray=[[NSMutableArray alloc] init];
    
    NSString *str11=@"The Reserve price is the minimum price at which the lot shall be sold.";
    clsAboutUs *objAboutUS11=[[clsAboutUs alloc]init];
    objAboutUS11.strName=str11;
    objAboutUS11.strType=@"1";
    [objhowtoBuy1.arrSubarray addObject:objAboutUS11];
    
    
    NSString *str12=@"The reserve price is confidential and will not be disclosed.";
    clsAboutUs *objAboutUS12=[[clsAboutUs alloc]init];
    objAboutUS12.strName=str12;
    objAboutUS12.strType=@"1";
    [objhowtoBuy1.arrSubarray addObject:objAboutUS12];
    
    [arrdata addObject:objhowtoBuy1];
    
    
    
    
    ClsHowToBuy *objhowtoBuy2=[[ClsHowToBuy alloc]init];
     objhowtoBuy2.arrSubarray=[[NSMutableArray alloc] init];
    objhowtoBuy2.Titlel=@"Buyers Premium";
    
    NSString *str21=@"In addition to the hammer price, the buyer agrees to pay Astaguru the buyer's premium calculated at 15% of the winning bid value on each lot.";
    clsAboutUs *objAboutUS21=[[clsAboutUs alloc]init];
    objAboutUS21.strName=[NSString stringWithFormat:@"%@",str21];
    objAboutUS21.strType=@"1";
    [objhowtoBuy2.arrSubarray addObject:objAboutUS21];
    
    NSString *str22=@"Service tax on the buyer's premium shall be applicable for paintings purchased within India.";
    clsAboutUs *objAboutUS22=[[clsAboutUs alloc]init];
    objAboutUS22.strName=[NSString stringWithFormat:@"%@",str22];//@"Service tax on the buyer's premium shall be applicable for paintings purchased within India.";
    objAboutUS22.strType=@"1";
    [objhowtoBuy2.arrSubarray addObject:objAboutUS22];
    
    [arrdata addObject:objhowtoBuy2];
    
    
    
    
    ClsHowToBuy *objhowtoBuy3=[[ClsHowToBuy alloc]init];
    objhowtoBuy3.Titlel=@"Payment";
    NSString *str31=@"Buyers will be required to complete payment within a period of 7 business days from the receipt of the invoice via email.";
    objhowtoBuy3.arrSubarray=[[NSMutableArray alloc] init];
    clsAboutUs *objAboutUS31=[[clsAboutUs alloc]init];
    objAboutUS31.strName=str31;
    objAboutUS31.strType=@"1";
    [objhowtoBuy3.arrSubarray addObject:objAboutUS31];
   
    
    ClsHowToBuy *objhowtoBuy4=[[ClsHowToBuy alloc]init];
    objhowtoBuy4.arrSubarray=[[NSMutableArray alloc] init];
    objhowtoBuy4.Titlel=@"Delivery / collection of purchase";
    NSString *str41=@"IWorks will be shipped within 7 days of the payment being cleared. Buyers may choose to collect their purchase from AstaGuru in Mumbai within 7 days from the date of the sale.";
    clsAboutUs *objAboutUS41=[[clsAboutUs alloc]init];
    objAboutUS41.strName=str41;
    objAboutUS41.strType=@"1";
    [objhowtoBuy4.arrSubarray addObject:objAboutUS41];
    
    NSString *str42=@"Buyers who have completed payment formalities and have not taken delivery of their art works from AstaGuru within 30 days of the completion of payment formalities will be charged demurrage @ 2% per month on the value of the artworks. ";
    clsAboutUs *objAboutUS42=[[clsAboutUs alloc]init];
    objAboutUS42.strName=str42;
    objAboutUS42.strType=@"1";
    [objhowtoBuy4.arrSubarray addObject:objAboutUS42];
    
    
    
    ClsHowToBuy *objhowtoBuy5=[[ClsHowToBuy alloc]init];
    objhowtoBuy5.Titlel=@"Participate in our next auction";
    NSString *str51=@"If you are interested in consigning works from your collection to our next sale, please contact us at contact@astaguru.com or at the auction help desk +912222048138 / 39";
    objhowtoBuy5.arrSubarray=[[NSMutableArray alloc] init];
    clsAboutUs *objAboutUS51=[[clsAboutUs alloc]init];
    objAboutUS51.strName=str51;
    objAboutUS51.strType=@"1";
    [objhowtoBuy5.arrSubarray addObject:objAboutUS51];
    
    NSString *str52=@"If you would like to stay informed of AstaGuru's upcoming events, please register with us online.";
    clsAboutUs *objAboutUS52=[[clsAboutUs alloc]init];
    objAboutUS52.strName=str52;
    objAboutUS52.strType=@"1";
    [objhowtoBuy5.arrSubarray addObject:objAboutUS52];
   
    
    
    
    
    ClsHowToBuy *objhowtoBuy6=[[ClsHowToBuy alloc]init];
    objhowtoBuy6.Titlel=@"Bidding";
    objhowtoBuy6.arrSubarray=[[NSMutableArray alloc] init];
    clsAboutUs *objAboutUS61=[[clsAboutUs alloc]init];
    objAboutUS61.strName=@"Pre -Registration and Verification.";
    objAboutUS61.strType=@"2";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS61];
    
   
    
    clsAboutUs *objAboutUS62=[[clsAboutUs alloc]init];
    objAboutUS62.strName=@"Prospective buyers should be registered and verified in order to bid.";
    objAboutUS62.strType=@"1";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS62];
    
    clsAboutUs *objAboutUS63=[[clsAboutUs alloc]init];
    objAboutUS63.strName=@"If you have already registered before, you will still need to pre-register and accept the terms and conditions for the sale. (Use your previous login Id).";
    objAboutUS63.strType=@"1";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS63];
    
    clsAboutUs *objAboutUS64=[[clsAboutUs alloc]init];
    objAboutUS64.strName=@"Fill the form online in order to pre-register, or call AstaGuru.";
    objAboutUS64.strType=@"1";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS64];
    
    clsAboutUs *objAboutUS65=[[clsAboutUs alloc]init];
    objAboutUS65.strName=@"Once you have pre-registered a representative will call you to verify your details.";
    objAboutUS65.strType=@"1";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS65];
    
    clsAboutUs *objAboutUS66=[[clsAboutUs alloc]init];
    objAboutUS66.strName=@"If the representative cannot reach you an email will be sent.";
    objAboutUS66.strType=@"1";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS66];
    
    clsAboutUs *objAboutUS67=[[clsAboutUs alloc]init];
    objAboutUS67.strName=@"Please note that if this process has not taken place you shall not be given bidding access.";
    objAboutUS67.strType=@"1";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS67];
    
    clsAboutUs *objAboutUS68=[[clsAboutUs alloc]init];
    objAboutUS68.strName=@"All bidding access shall be provided 24 hours before the auction.";
    objAboutUS68.strType=@"1";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS68];
    
    clsAboutUs *objAboutUS69=[[clsAboutUs alloc]init];
    objAboutUS69.strName=@"Once your application has been accepted you shall receive an email confirming your bidding access along with your Login Id and password.";
    objAboutUS69.strType=@"1";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS69];
    
    clsAboutUs *objAboutUS610=[[clsAboutUs alloc]init];
    objAboutUS610.strName=@"Absentee Bids";
    objAboutUS610.strType=@"2";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS610];
    
    clsAboutUs *objAboutUS611=[[clsAboutUs alloc]init];
    objAboutUS611.strName=@"You may place an absentee bid, by faxing the written bid form available online and in the printed catalogue.";
    objAboutUS611.strType=@"1";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS611];
    
    clsAboutUs *objAboutUS612=[[clsAboutUs alloc]init];
    objAboutUS612.strName=@"All bids must come in 24 hours before the auction.";
    objAboutUS612.strType=@"1";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS612];
    
    clsAboutUs *objAboutUS613=[[clsAboutUs alloc]init];
    objAboutUS613.strName=@"Proxy Bids";
    objAboutUS613.strType=@"2";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS613];
    
    clsAboutUs *objAboutUS614=[[clsAboutUs alloc]init];
    objAboutUS614.strName=@"Proxy bids shall be placed on the website once the auction catalogue goes live and will be available until the end of the auction.";
    objAboutUS614.strType=@"1";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS614];
    
    clsAboutUs *objAboutUS615=[[clsAboutUs alloc]init];
    objAboutUS615.strName=@"Once you have identified the lot that you would like to bid on, click on 'Proxy bid' and enter desired amount(10% more than the previous bid) and confirm your bid at the value submitted.";
    objAboutUS615.strType=@"1";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS615];
    
    clsAboutUs *objAboutUS616=[[clsAboutUs alloc]init];
    objAboutUS616.strName=@"In case of the 'No Reserve' auction all proxy bid values start at Rs 20,000.";
    objAboutUS616.strType=@"1";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS616];
    
    clsAboutUs *objAboutUS617=[[clsAboutUs alloc]init];
    objAboutUS617.strName=@"Proxy bid placed on a lot before an auction cannot be resubmitted online. Users can update such proxy bids by submitting a duly signed written bid form provided on the website.";
    objAboutUS617.strType=@"1";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS617];
    
    clsAboutUs *objAboutUS618=[[clsAboutUs alloc]init];
    objAboutUS618.strName=@"In case a user is outbid on their proxy, they will be intimated of the same and can update the proxy online if they wish to so.";
    objAboutUS618.strType=@"1";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS618];
    
    clsAboutUs *objAboutUS619=[[clsAboutUs alloc]init];
    objAboutUS619.strName=@"Astaguru reserves the right to reject any proxy bid at its discretion without having to provide any explaination.";
    objAboutUS619.strType=@"1";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS619];
    
    clsAboutUs *objAboutUS620=[[clsAboutUs alloc]init];
    objAboutUS620.strName=@"Opening Bid";
    objAboutUS620.strType=@"2";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS620];
    
    clsAboutUs *objAboutUS621=[[clsAboutUs alloc]init];
    objAboutUS621.strName=@"Opening Bid is the value at which the auction house starts the bidding of each lot.";
    objAboutUS621.strType=@"1";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS621];
    
    clsAboutUs *objAboutUS622=[[clsAboutUs alloc]init];
    objAboutUS622.strName=@"Opening bid is 20% lower than value of the lower estimate.";
    objAboutUS622.strType=@"1";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS622];
    
    clsAboutUs *objAboutUS623=[[clsAboutUs alloc]init];
    objAboutUS623.strName=@"In case of the 'No Reserve' auction all bids start at Rs 20,000.";
    objAboutUS623.strType=@"1";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS623];
    
    clsAboutUs *objAboutUS624=[[clsAboutUs alloc]init];
    objAboutUS624.strName=@"Bidding Online";
    objAboutUS624.strType=@"2";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS624];
    
    clsAboutUs *objAboutUS625=[[clsAboutUs alloc]init];
    objAboutUS625.strName=@"Once you have identified the lot that you would like to bid on, click on 'Bid Now' confirm your bid at the value listed";
    objAboutUS625.strType=@"1";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS625];
    
    clsAboutUs *objAboutUS626=[[clsAboutUs alloc]init];
    objAboutUS626.strName=@"This is where you participate in the bidding process, by entering the next valid bid each time you are out-bid.";
    objAboutUS626.strType=@"1";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS626];
    
    clsAboutUs *objAboutUS627=[[clsAboutUs alloc]init];
    objAboutUS627.strName=@"The next valid bid will be a 10% increment in value of the last valid bid.";
    objAboutUS627.strType=@"1";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS627];
    
    clsAboutUs *objAboutUS628=[[clsAboutUs alloc]init];
    objAboutUS628.strName=@"All lots bid history will be made available to be viewed.";
    objAboutUS628.strType=@"1";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS628];
    
    clsAboutUs *objAboutUS629=[[clsAboutUs alloc]init];
    objAboutUS629.strName=@"Bid Increments";
    objAboutUS629.strType=@"2";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS629];
    
    clsAboutUs *objAboutUS630=[[clsAboutUs alloc]init];
    objAboutUS630.strName=@"All bids will have an increment of 10% of the current valid bid";
    objAboutUS630.strType=@"1";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS630];
    
    clsAboutUs *objAboutUS631=[[clsAboutUs alloc]init];
    objAboutUS631.strName=@"Personalized Bid Notifications";
    objAboutUS631.strType=@"2";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS631];
    
    clsAboutUs *objAboutUS632=[[clsAboutUs alloc]init];
    objAboutUS632.strName=@"In case you're outbid on a particular lot you will be notified of the same on your registered email and mobile number.";
    objAboutUS632.strType=@"1";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS632];
    
    clsAboutUs *objAboutUS633=[[clsAboutUs alloc]init];
    objAboutUS633.strName=@"In case you've won a particular lot in an auction you will be notified of the same on your registered email and mobile number.";
    objAboutUS633.strType=@"1";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS633];
    
    clsAboutUs *objAboutUS634=[[clsAboutUs alloc]init];
    objAboutUS634.strName=@"Bid History";
    objAboutUS634.strType=@"2";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS634];
    
    clsAboutUs *objAboutUS635=[[clsAboutUs alloc]init];
    objAboutUS635.strName=@"Bid history indicates the value recorded for each lot since the start of the auction";
    objAboutUS635.strType=@"1";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS635];
    
    clsAboutUs *objAboutUS636=[[clsAboutUs alloc]init];
    objAboutUS636.strName=@"Bid History will not be displayed once the auction has closed.";
    objAboutUS636.strType=@"1";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS636];
    
    clsAboutUs *objAboutUS637=[[clsAboutUs alloc]init];
    objAboutUS637.strName=@"Currency of Bidding";
    objAboutUS637.strType=@"2";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS637];
    
    clsAboutUs *objAboutUS638=[[clsAboutUs alloc]init];
    objAboutUS638.strName=@"Bids can be placed in US Dollars (USD) or Indian Rupees (INR).";
    objAboutUS638.strType=@"1";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS638];
    
    clsAboutUs *objAboutUS639=[[clsAboutUs alloc]init];
    objAboutUS639.strName=@"Buyers in India must pay for their purchase in INR and all other buyers must pay in USD";
    objAboutUS639.strType=@"1";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS639];
    
    clsAboutUs *objAboutUS640=[[clsAboutUs alloc]init];
    objAboutUS640.strName=@"Closing and Winning Bid";
    objAboutUS640.strType=@"2";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS640];
    
    clsAboutUs *objAboutUS641=[[clsAboutUs alloc]init];
    objAboutUS641.strName=@"Winning bid is the last and highest bid at which the lot has closed.";
    objAboutUS641.strType=@"1";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS641];
    
    clsAboutUs *objAboutUS642=[[clsAboutUs alloc]init];
    objAboutUS642.strName=@"No new bids cannot be placed after the close of a lot.";
    objAboutUS642.strType=@"1";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS642];
    
    clsAboutUs *objAboutUS643=[[clsAboutUs alloc]init];
    objAboutUS643.strName=@"The closing bid is considered the winning bid only if the bid exceeds the reserve price.";
    objAboutUS643.strType=@"1";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS643];
    
    clsAboutUs *objAboutUS644=[[clsAboutUs alloc]init];
    objAboutUS644.strName=@"All winning bids shall be posted on the website after the close of the auction.";
    objAboutUS644.strType=@"1";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS644];
    
    clsAboutUs *objAboutUS645=[[clsAboutUs alloc]init];
    objAboutUS645.strName=@"Bid Cancellation";
    objAboutUS645.strType=@"2";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS645];
    
    clsAboutUs *objAboutUS646=[[clsAboutUs alloc]init];
    objAboutUS646.strName=@"Once any bid and/or proxy bid has been placed, it cannot be cancelled. AstaGuru reserves the rights to cancel any bids in order to protect the efficacy of the bidding process.";
    objAboutUS646.strType=@"1";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS646];
    
    clsAboutUs *objAboutUS647=[[clsAboutUs alloc]init];
    objAboutUS647.strName=@"Buyers Premium";
    objAboutUS647.strType=@"2";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS647];
    
    clsAboutUs *objAboutUS648=[[clsAboutUs alloc]init];
    objAboutUS648.strName=@"In addition to the hammer price, the buyer agrees to pay to us the buyers premium calculated at 15% of the winning bid value on each lot.";
    objAboutUS648.strType=@"1";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS648];
    
    clsAboutUs *objAboutUS649=[[clsAboutUs alloc]init];
    objAboutUS649.strName=@"Service tax on the buyers premium shall be applicable for paintings purchased within India.";
    objAboutUS649.strType=@"1";
    [objhowtoBuy6.arrSubarray addObject:objAboutUS649];
    
    [arrdata addObject:objhowtoBuy6];

    
    
    ClsHowToBuy *objhowtoBuy7=[[ClsHowToBuy alloc]init];
    objhowtoBuy7.Titlel=@"After Sale";
    objhowtoBuy7.arrSubarray=[[NSMutableArray alloc] init];
    clsAboutUs *objAboutUS71=[[clsAboutUs alloc]init];
    objAboutUS71.strName=@"If you have won a lot you shall be informed via email after the auction has closed.";
    objAboutUS71.strType=@"1";
    [objhowtoBuy7.arrSubarray addObject:objAboutUS71];
    
    
    
    clsAboutUs *objAboutUS72=[[clsAboutUs alloc]init];
    objAboutUS72.strName=@"You shall there after receive an email with the invoice stating buyers premium along with related taxes.";
    objAboutUS72.strType=@"1";
    [objhowtoBuy7.arrSubarray addObject:objAboutUS72];
    
    clsAboutUs *objAboutUS73=[[clsAboutUs alloc]init];
    objAboutUS73.strName=@"If you are the winning bidder, you are legally bound to purchase the item from AstaGuru. Please note that purchases will not be shipped out until full payment has been received and cleared.";
    objAboutUS73.strType=@"1";
    [objhowtoBuy7.arrSubarray addObject:objAboutUS73];
    
    clsAboutUs *objAboutUS74=[[clsAboutUs alloc]init];
    objAboutUS74.strName=@"Invoicing";
    objAboutUS74.strType=@"2";
    [objhowtoBuy7.arrSubarray addObject:objAboutUS74];
    
    clsAboutUs *objAboutUS75=[[clsAboutUs alloc]init];
    objAboutUS75.strName=@"All details for the invoice are to be provided prior to the auction.";
    objAboutUS75.strType=@"1";
    [objhowtoBuy7.arrSubarray addObject:objAboutUS75];
    
    clsAboutUs *objAboutUS76=[[clsAboutUs alloc]init];
    objAboutUS76.strName=@"After the sale, the Buyer as invoiced is required to pay the amounts in full (including the additional charges).";
    objAboutUS76.strType=@"1";
    [objhowtoBuy7.arrSubarray addObject:objAboutUS76];
    
    clsAboutUs *objAboutUS77=[[clsAboutUs alloc]init];
    objAboutUS77.strName=@"No lots shall be sent without payment made in full.";
    objAboutUS77.strType=@"1";
    [objhowtoBuy7.arrSubarray addObject:objAboutUS77];
    
    clsAboutUs *objAboutUS78=[[clsAboutUs alloc]init];
    objAboutUS78.strName=@"Shipping and Insurance";
    objAboutUS78.strType=@"2";
    [objhowtoBuy7.arrSubarray addObject:objAboutUS78];
    
    clsAboutUs *objAboutUS79=[[clsAboutUs alloc]init];
    objAboutUS79.strName=@"Price estimates do not include any packing, insurance, shipping or handling charges, all of which will be borne by the buyer.";
    objAboutUS79.strType=@"1";
    [objhowtoBuy7.arrSubarray addObject:objAboutUS79];
    
    clsAboutUs *objAboutUS710=[[clsAboutUs alloc]init];
    objAboutUS710.strName=@"Shipping will be charged on courier rates and are determined by the size, weight and destination of the package.";
    objAboutUS710.strType=@"1";
    [objhowtoBuy7.arrSubarray addObject:objAboutUS710];
    
    clsAboutUs *objAboutUS711=[[clsAboutUs alloc]init];
    objAboutUS711.strName=@"Please also note for international shipments from India the additional charges calculated are only till the destination port. Import-related duties, taxes delivery and any other charges, wherever applicable, will be directly paid by the buyer.";
    objAboutUS711.strType=@"1";
    [objhowtoBuy7.arrSubarray addObject:objAboutUS711];
    
    clsAboutUs *objAboutUS712=[[clsAboutUs alloc]init];
    objAboutUS712.strName=@"Duties & Taxes";
    objAboutUS712.strType=@"2";
    [objhowtoBuy7.arrSubarray addObject:objAboutUS712];
    
    clsAboutUs *objAboutUS713=[[clsAboutUs alloc]init];
    objAboutUS713.strName=@"All duties and taxes shall be borne by the buyer.";
    objAboutUS713.strType=@"1";
    [objhowtoBuy7.arrSubarray addObject:objAboutUS713];
    
    clsAboutUs *objAboutUS714=[[clsAboutUs alloc]init];
    objAboutUS714.strName=@"All sales in India shall attract 13.5% VAT on the winning bid and 14% service tax and 0.5% swachh bharat cess and 0.5% krishi kalyan cess on the buyer's premium International sales.";
    objAboutUS714.strType=@"1";
    [objhowtoBuy7.arrSubarray addObject:objAboutUS714];
    
    clsAboutUs *objAboutUS715=[[clsAboutUs alloc]init];
    objAboutUS715.strName=@"There shall be no VAT and Service tax in International sales.";
      objAboutUS715.strType=@"1";
    [objhowtoBuy7.arrSubarray addObject:objAboutUS715];
    [arrdata addObject:objhowtoBuy7];
    [arrdata addObject:objhowtoBuy3];
    [arrdata addObject:objhowtoBuy4];
    [arrdata addObject:objhowtoBuy5];
    
    
    /*ClsHowToBuy *objhowtoBuy8=[[ClsHowToBuy alloc]init];
    objhowtoBuy8.Titlel=@"";
    objhowtoBuy8.arrSubarray=[[NSMutableArray alloc] init];
    [arrdata addObject:objhowtoBuy8];*/
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [arrdata count];
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClsHowToBuy *objHowToBuy = [arrdata objectAtIndex:indexPath.section] ;
    clsAboutUs *objAboutUs=[objHowToBuy.arrSubarray objectAtIndex:indexPath.row];
    UITableViewCell* cell1;
    if ([objAboutUs.strType intValue]==1)
    {
        
    
    static NSString* cellIdentifier = @"HowToBuy";
    
    UITableViewCell* cell = [_tblHowtoBuy dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    

    //NSString *text=objHowToBuy.Titlel;
    TTTAttributedLabel *lblSubtitle=(TTTAttributedLabel *)[cell viewWithTag:12];
    //lblSubtitle.text=objAboutUs.strName;
     
        
//        NSMutableParagraphStyle *paragraphStyles = [[NSMutableParagraphStyle alloc] init];
//        paragraphStyles.alignment                = NSTextAlignmentJustified;    // To justified text
//        paragraphStyles.firstLineHeadIndent      = 0.05;    // IMP: must have a value to make it work
//        
//        NSString *stringTojustify                = objAboutUs.strName;
//        NSDictionary *attributes                 = @{NSParagraphStyleAttributeName: paragraphStyles,(id)kCTForegroundColorAttributeName : (id)[UIColor colorWithRed:96.0/255.0 green:96.0/255.0 blue:96.0/255.0 alpha:1.0].CGColor,NSFontAttributeName : [UIFont fontWithName:@"WorkSans-Regular" size:14]};
//        NSMutableAttributedString *attributedString     = [[NSMutableAttributedString alloc] initWithString:stringTojustify attributes:attributes];
//        lblSubtitle.attributedText             = attributedString;
//        lblSubtitle.numberOfLines              = 0;
//        [lblSubtitle sizeToFit];
        lblSubtitle.extendsLinkTouchArea = YES;
        lblSubtitle.textAlignment = NSTextAlignmentJustified;
        lblSubtitle.enabledTextCheckingTypes = NSTextCheckingAllSystemTypes; // Automatically detect links when the label text is subsequently changed
        lblSubtitle.delegate = self; // Delegate methods are called when the user taps on a link (see `TTTAttributedLabelDelegate` protocol)
        lblSubtitle.numberOfLines = 0;
        lblSubtitle.text = objAboutUs.strName; // Repository URL will be automatically detected and linked

//        lblSubtitle.enabledTextCheckingTypes = NSTextCheckingTypeLink;
//        NSRange range = [lblSubtitle.text rangeOfString:@"contact@astaguru.com"];
//        NSRange range1 = [lblSubtitle.text rangeOfString:@"+912222048138 / 39"];
//        [lblSubtitle addLinkToURL:[NSURL URLWithString:@"http://arttrust.southeastasia.cloudapp.azure.com/"] withRange:range];
//        [lblSubtitle addLinkToPhoneNumber:@"912222048138" withRange:range1];
    // lblSubtitle.textAlignment = NSTextAlignmentJustified;
        cell1=cell;
   
    }
    else if ([objAboutUs.strType intValue]==2)
    {
        static NSString* cellIdentifier = @"TitlesInSubTitles";
        
        UITableViewCell* cell = [_tblHowtoBuy dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        //NSString *text=objHowToBuy.Titlel;
        UILabel *lblSubtitle=(UILabel *)[cell viewWithTag:13];
        
        //lblSubtitle.text=objAboutUs.strName;
        //lblSubtitle.textAlignment = NSTextAlignmentJustified;
        
        NSMutableParagraphStyle *paragraphStyles = [[NSMutableParagraphStyle alloc] init];
        paragraphStyles.alignment                = NSTextAlignmentJustified;    // To justified text
        paragraphStyles.firstLineHeadIndent      = 0.05;    // IMP: must have a value to make it work
        
        NSString *stringTojustify                = objAboutUs.strName;
        NSDictionary *attributes                 = @{NSParagraphStyleAttributeName: paragraphStyles};
        NSAttributedString *attributedString     = [[NSAttributedString alloc] initWithString:stringTojustify attributes:attributes];
        
        
        
        lblSubtitle.attributedText             = attributedString;
        lblSubtitle.numberOfLines              = 0;
        [lblSubtitle sizeToFit];
        cell1=cell;
    
    }
    else if ([objAboutUs.strType intValue]==3)
    {
        
        
        static NSString* cellIdentifier = @"TextWithOutIcon";
        
        UITableViewCell* cell = [_tblHowtoBuy dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        //NSString *text=objHowToBuy.Titlel;
        UILabel *lblSubtitle=(UILabel *)[cell viewWithTag:12];
        //lblSubtitle.text=objAboutUs.strName;
        //lblSubtitle.textAlignment = NSTextAlignmentJustified;
        NSMutableParagraphStyle *paragraphStyles = [[NSMutableParagraphStyle alloc] init];
        paragraphStyles.alignment                = NSTextAlignmentJustified;    // To justified text
        paragraphStyles.firstLineHeadIndent      = 0.05;    // IMP: must have a value to make it work
        
        NSString *stringTojustify                = objAboutUs.strName;
        NSDictionary *attributes                 = @{NSParagraphStyleAttributeName: paragraphStyles};
        NSAttributedString *attributedString     = [[NSAttributedString alloc] initWithString:stringTojustify attributes:attributes];
        
        lblSubtitle.attributedText             = attributedString;
        lblSubtitle.numberOfLines              = 0;
        [lblSubtitle sizeToFit];

        
        cell1=cell;
        
    }
    else if ([objAboutUs.strType intValue]==4)
    {
        
        
        static NSString* cellIdentifier = @"ApplyNow";
        
        UITableViewCell* cell = [_tblHowtoBuy dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        //NSString *text=objHowToBuy.Titlel;
        /*UILabel *lblSubtitle=(UILabel *)[cell viewWithTag:12];
         //lblSubtitle.text=objAboutUs.strName;
         //lblSubtitle.textAlignment = NSTextAlignmentJustified;
         NSMutableParagraphStyle *paragraphStyles = [[NSMutableParagraphStyle alloc] init];
         paragraphStyles.alignment                = NSTextAlignmentJustified;    // To justified text
         paragraphStyles.firstLineHeadIndent      = 0.05;    // IMP: must have a value to make it work
         
         NSString *stringTojustify                = objAboutUs.strName;
         NSDictionary *attributes                 = @{NSParagraphStyleAttributeName: paragraphStyles};
         NSAttributedString *attributedString     = [[NSAttributedString alloc] initWithString:stringTojustify attributes:attributes];
         
         lblSubtitle.attributedText             = attributedString;
         lblSubtitle.numberOfLines              = 0;
         [lblSubtitle sizeToFit];*/
        
        
        cell1=cell;
        
    }

    
 return cell1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ClsHowToBuy *objHowToBuy = [arrdata objectAtIndex:section] ;
    if(section<arrdata.count-1)
    {
    HeaderView *headerView=[arrHeaderview objectAtIndex:section];
    BOOL sectionIsOpen = [_tblHowtoBuy isOpenSection:section];
    
    if (sectionIsOpen)
    {
        headerView.imgCheckbox.image=[UIImage imageNamed:@"icon-expanded"];
    }else
    {
        headerView.imgCheckbox.image=[UIImage imageNamed:@"icon-collapsed"];
    }
    }
    return  objHowToBuy.arrSubarray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
     return 40;
    /*if(section<arrdata.count-1)
    {
        
     
    }
    else
    {
        return self.view.frame.size.width/1.5;
    }*/
}
/*- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    ClsHowToBuy *objHowToBuy = [arrdata objectAtIndex:indexPath.section] ;
    clsAboutUs *objAboutUs=[objHowToBuy.arrSubarray objectAtIndex:indexPath.row];
    //NSString *text=objHowToBuy.Titlel;
   
    if ([objAboutUs.strType intValue]==1)
    {
    
    CGSize maximumLabelSize = CGSizeMake(tableView.frame.size.width-31, FLT_MAX);
    CGRect labelRect1 = [objAboutUs.strName
                         boundingRectWithSize:maximumLabelSize
                         options:NSStringDrawingUsesLineFragmentOrigin
                         attributes:@{
                                      NSFontAttributeName : [UIFont fontWithName:@"WorkSans-Regular" size:15]
                                      }
                         context:nil];
    return   labelRect1.size.height+10;
    }
    else if ([objAboutUs.strType intValue]==3)
    {
        CGSize maximumLabelSize = CGSizeMake(tableView.frame.size.width-45, FLT_MAX);
        CGRect labelRect1 = [objAboutUs.strName
                             boundingRectWithSize:maximumLabelSize
                             options:NSStringDrawingUsesLineFragmentOrigin
                             attributes:@{
                                          NSFontAttributeName : [UIFont fontWithName:@"WorkSans-Regular" size:14]
                                          }
                             context:nil];
        return   labelRect1.size.height;
    }
    else
    {
        CGSize maximumLabelSize = CGSizeMake(tableView.frame.size.width-20, FLT_MAX);
        CGRect labelRect1 = [objAboutUs.strName
                             boundingRectWithSize:maximumLabelSize
                             options:NSStringDrawingUsesLineFragmentOrigin
                             attributes:@{
                                          NSFontAttributeName : [UIFont fontWithName:@"WorkSans-Regular" size:15]
                                          }
                             context:nil];
        return   labelRect1.size.height+8;
    }
    
}*/
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
   // if (section<arrdata.count-1)
    //{
       
   
//    CGRect frame = tableView.frame;
    //static NSString *CellIdentifier = @"Header";
    ClsHowToBuy *objHowToBuy = [arrdata objectAtIndex:section] ;
    
    // NSString *strSection=[NSString stringWithFormat:@"%d",section];
//    NSString *HeaderIdentifier =[NSString stringWithFormat:@"%ld",(long)section];
    
    HeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HeaderView"];
    if(!headerView)
    {
        //    [tableView registerClass:[CustomHeaderView class] forHeaderFooterViewReuseIdentifier:HeaderIdentifier];
        headerView = [[[NSBundle mainBundle] loadNibNamed:@"HeaderView"  owner:self  options:nil]objectAtIndex:0];
    }
    headerView.lblTitle.text=objHowToBuy.Titlel;
   
    [headerView.btnCheck addTarget:self action:@selector(infoButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
   
    headerView.btnCheck.tag=section;
    
    BOOL sectionIsOpen = [_tblHowtoBuy isOpenSection:section];
    
    if (sectionIsOpen)
    {
        headerView.imgCheckbox.image=[UIImage imageNamed:@"icon-expanded.png"];
    }else
    {
        headerView.imgCheckbox.image=[UIImage imageNamed:@"icon-collapsed.png"];
    }
    
    [arrHeaderview addObject:headerView];
    return headerView;
    //return [self.headers objectAtIndex:section];
   /* }
    else
    {
        CGRect frame = tableView.frame;
        //static NSString *CellIdentifier = @"Header";
        ClsHowToBuy *objHowToBuy = [arrdata objectAtIndex:section] ;
        
        // NSString *strSection=[NSString stringWithFormat:@"%d",section];
        NSString *HeaderIdentifier =[NSString stringWithFormat:@"%ld",(long)section];
        
        VideoViewInHowToBuy *VideoView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderIdentifier];
        if(!VideoView)
        {
            //    [tableView registerClass:[CustomHeaderView class] forHeaderFooterViewReuseIdentifier:HeaderIdentifier];
            VideoView = [[[NSBundle mainBundle] loadNibNamed:@"VideoViewInHowToBuy"  owner:self  options:nil]objectAtIndex:0];
            
            
            NSString *strVideoId=[self extractYoutubeIdFromLink:@"https://youtu.be/-V9WmhujSx4"];
            NSDictionary *playerVars = @{
                                         @"controls" : @0,
                                         @"playsinline" : @0,
                                         @"autohide" : @1,
                                         @"showinfo" : @0,
                                         @"modestbranding" : @0,
                                         @"autoplay" : @0,
                                         @"origin":@"http://www.youtube.com"
                                         };
            
            // NSLog(@"strlib_video_thumb %@",_objLib.strlib_video_thumb);
            [VideoView.videoPlayer loadWithVideoId:strVideoId playerVars:playerVars];
            [VideoView.videoPlayer playVideo];
            
            VideoView.videoPlayer.delegate=self;
             [_tblHowtoBuy openSection:section animated:NO];

            
        }
       
        
        
        
        return VideoView;
    }*/
}

- (void)playerView:(YTPlayerView *)playerView didChangeToState:(YTPlayerState)state {
    switch (state) {
        case kYTPlayerStatePlaying:
        {
            //_imgVideo.hidden=YES;
        }
            break;
        case kYTPlayerStatePaused:
            NSLog(@"Paused playback");
            break;
        default:
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
    
    // If you are not using ARC:
    // return [[UIView new] autorelease];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}
- (void)infoButtonClicked:(UIButton*)sender
{
    NSLog(@"handleTapGesture11:%ld",(long)sender.tag);
    //- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
    
//    VideoViewInHowToBuy *headerView=(VideoViewInHowToBuy*)[_tblHowtoBuy headerViewForSection:sender.tag];
    
    [self.tblHowtoBuy reloadData];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 60;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}
- (NSString *)extractYoutubeIdFromLink:(NSString *)link {
    
    NSString *regexString = @"((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)";
    NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:regexString
                                                                            options:NSRegularExpressionCaseInsensitive
                                                                              error:nil];
    
    NSArray *array = [regExp matchesInString:link options:0 range:NSMakeRange(0,link.length)];
    if (array.count > 0) {
        NSTextCheckingResult *result = array.firstObject;
        return [link substringWithRange:result.range];
    }
    return nil;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)viewWillDisappear:(BOOL)animated
{
    _tblHowtoBuy.delegate = nil;
    //[_tblHowtoBuy release];
    _tblHowtoBuy = nil;
}

#pragma mark - TTTAttributedLabelDelegate

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithPhoneNumber:(NSString *)phoneNumber
{
    //    NSString *numberString = self.product_Dic[@"contactNo"]; //@"7875512881";
    //        NSURL *phoneNumber = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", numberString]];
    
    //        // Whilst this version will return you to your app once the phone call is over.
    NSURL *phoneNumber_Url = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", phoneNumber]];
    
    // Now that we have our `phoneNumber` as a URL. We need to check that the device we are using can open the URL.
    // Whilst iPads, iPhone, iPod touchs can all open URLs in safari mobile they can't all
    // open URLs that are numbers this is why we have `tel://` or `telprompt://`
    if([[UIApplication sharedApplication] canOpenURL:phoneNumber_Url]) {
        // So if we can open it we can now actually open it with
        [[UIApplication sharedApplication] openURL:phoneNumber_Url];
    }
    
}

- (void)attributedLabel:(__unused TTTAttributedLabel *)label
   didSelectLinkWithURL:(NSURL *)url
{
    [[UIApplication sharedApplication] openURL:url];

//    [[[UIActionSheet alloc] initWithTitle:[url absoluteString] delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Open Link in Safari", nil), nil] showInView:self.view];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet
clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        return;
    }
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:actionSheet.title]];
}

- (IBAction)btnApplyNow:(id)sender
{
    UINavigationController *navcontroll = (UINavigationController *)[self.revealViewController frontViewController];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ClientRelationViewController *objProductViewController = [storyboard instantiateViewControllerWithIdentifier:@"ClientRelationViewController"];
    objProductViewController.arrJobTotle=arrVAcncyTitleOnly;
    [navcontroll pushViewController:objProductViewController animated:YES];
}


@end
