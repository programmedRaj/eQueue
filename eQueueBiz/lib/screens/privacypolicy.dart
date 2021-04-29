import 'package:equeuebiz/constants/appcolor.dart';
import 'package:flutter/material.dart';

class Policy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.mainBlue,
        title: Text(
          'Privacy Policy',
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 18),
                children: [
                  TextSpan(
                      text: 'eQueue.app is a product of Bido Media Inc.\n \n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: 'eQueue.app Privacy Policy\n \n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          'Bido Media Inc. (“e-Queue,” “equeue.app,” “our,” “we,” or “us”) provide token (or number) for services which provide by companies to their clients or customers via equeue mobile app. Please read our terms of service so you understand what’s up with your use of our product “equeue.” You agree to our terms of services (“Terms”) by installing, accessing or using our apps, services, features. Software or website (“together our “Services.”)\n\n'),
                  TextSpan(
                      text: 'PRIVACY POLICY\n\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          'Bido Media Inc. uses personal information to better understand your needs and interest and provide you with better service. Once you choose to provide us with personal information, you can be assured that it will only be used to support your customer relationship with Bido Media Inc.. We take seriously the trust you place in us. Bido Media Inc. will not sell, rent or lease your personally identifiable information to others. This privacy statement covers personally identifiable information, anonymous data collection and aggregate reporting. Personally identifiable information is any information that is associated with your name or personal identity. Anonymous (non-personal) information is data about usage and service operation, reported in aggregate, which is not associated to a specific personal identity. Aggregate information is data collected and summarized for a broad category of customers or Bido Media Inc. products and services.\n\n'),
                  TextSpan(text: 'WHAT WE COLLECT\n'),
                  TextSpan(
                      text:
                          '\n On some Bido Media Inc. web sites or mobile applications, you can order products or services, make information requests, subscribe to marketing or support materials, or register yourself. The types of personal information you provide to us on these pages may include name, address, phone, email address, user IDs, GPS location and passwords, billing information and contact preferences. To personalize our web sites and/or mobile apps, services or communications and improve our products and services, we may also ask you to provide us with information regarding your personal or professional interests, demographics, and experiences with our products or services. Providing this additional information is optional. Anonymous (non-personal) data we collect may include the pages visited on EQUEUE.APP, unique URLs visited within EQUEUE.APP, browser type and IP address. Most anonymous data is collected via cookies or other analysis technologies. EQUEUE.APP web pages and/or mobile apps use cookies, web beacons and other technologies for data analysis and personalization services.'),
                  TextSpan(
                      text:
                          '\n \n This may include:\nUser profile: We collect information when you create or update your EQUEUE.APP account. This may include your name, email, phone number, login name and password, address, payment or banking information (including related payment verification information), government identification numbers such as Social Security number, driver’s license or passport if required by law, birth date, photo and signature. This also includes the preferences and settings that you enable for your EQUEUE.APP account.\nBackground check information: We may collect background check information if you sign up to use EQUEUE.APP services as partner or merchant. This may include information such as your history or criminal record (where permitted by law). This information may be collected by a vendor on Bido Media, Inc. behalf.\nDemographic data: We may collect demographic information about you, including through user surveys. In some countries, we may also receive demographic information about you from third parties.\nUser content: We may collect information that you submit when you contact EQUEUE.APP customer support, provide ratings or compliments for other users, or otherwise contact EQUEUE.APP.'),
                  TextSpan(
                      text:
                          '\n \n INFORMATION CREATED WHEN YOU USE OUR SERVICES',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          '\n This may include:- \n Location Information: Depending on the EQUEUE.APP services that you use, and your app settings or device permissions, we may collect your precise or approximate location information as determined through data such as GPS, IP address and WiFi.\n Transaction Information: We collect transaction details related to your use of our services, including the type of services you requested or provided, your order details, delivery information, date and time the service was provided, amount charged, distance traveled, and payment method. Additionally, if someone uses your promotion code, we may associate your name with that person. \n Usage information: We collect information about how you interact with our services. This includes information such as access dates and times, app features or pages viewed, app crashes and other system activity, type of browser, and third-party sites or service you were using before interacting with our services. In some cases, we collect this information through cookies, pixel tags, and similar technologies that create and maintain unique identifiers. To learn more about these technologies. \n Device Information: We may collect information about the devices you use to access our services, including the hardware models, device IP address, operating systems and versions, software, file names and versions, preferred languages, unique device identifiers, advertising identifiers, serial numbers, device motion information, and mobile network information. \n  Communications data: We enable users to communicate with each other and EQUEUE.APP through the EQUEUE.APP apps, websites, and other services. To provide this service, EQUEUE.APP receives some information regarding the calls or texts, including the date and time of the call/text, and the content of the communications. EQUEUE.APP may also use this information for customer support services (including to resolve disputes between users), for safety and security purposes, to improve our products and services and for analytics. \n'),
                  TextSpan(
                      text: '\n \n Information from other sources:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: '\n \n These may include:'),
                  TextSpan(
                      text:
                          '\n \n User feedback, such as ratings or compliments. \n Users providing your information in connection with referral programs. \nUsers requesting services for or on your behalf. \nUsers or others providing information in connection with claims or disputes. \nEQUEUE.APP may combine the information collected from these sources with other information in its possession. \n'),
                  TextSpan(
                      text: '\n \n HOW WE USE IT',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          '\n\n EQUEUE.APP uses your information to help us understand your needs and interests and provide you with better services. Specifically, we use your information to help you complete a transaction or order, to communicate with you, to provide service and support, to update you on services and benefits, to personalize promotional offers and to personalize our web sites. Occasionally we may also use your information to contact you for market research regarding EQUEUE.APP products or services. We will give you the opportunity to opt-out of market research and customer surveys. Data collected online may also be combined with information you provide through other sources such as product registration, call centers or public events such as trade shows or seminars. Anonymous (non-personal) data is aggregated for reporting about EQUEUE.APP web site usability, performance, and effectiveness. It is used to improve the customer experience, usability and site content.'),
                  TextSpan(
                      text: '\n \n WHO WE SHARE IT WITH',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          '\n \n Bido Media, Inc. will not sell, rent, or lease your personally identifiable information to others. Bido Media, Inc. will not share your personal information with a business partner or any unrelated third party company unless you give your permission. Your permission will be requested when you submit your information. Bido Media, Inc. shares customer information across Bido Media, Inc. business entities and our associated companies, within the usage limits described above in "How we use it".'),
                  TextSpan(
                      text: '\n \n CHOICE',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          "\n \n You can subscribe to receive some products and service-specific information and Bido Media, Inc. wide marketing communications. Bido Media, Inc. wide communications may include new product information, special offers or possibly an invitation to participate in market research. We give you a choice regarding Bido Media, Inc. wide communications by postal mail, email and telephone. Links provided on Bido Media, Inc. to third party web sites are provided as a convenience and Bido Media, Inc. does not control those sites or their privacy practices, which may differ from ours. Bido Media, Inc. does not endorse or make any representations about them. We encourage you to review the privacy policy of any company before submitting your personal information. The personal data you choose to give to unrelated third parties is covered by their privacy policies, not the Bido Media, Inc. Privacy Policy. Some third-party companies may choose to share their personal data with Bido Media, Inc.; that sharing is governed by that third-party company's privacy policy.\nIf you disable the device location services on your device, your use of the EQUEUE.APP app will be affected. EQUEUE.APP strives to control the user location for best services.\nYou may enable EQUEUE.APP to send you push notifications about discounts and news from EQUEUE.APP or Merchants. You may enable/disable these notifications at any time through the Privacy Settings in the Android/iOS setting."),
                  TextSpan(
                      text: '\n \n ONWARD TRANSFER',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          '\nPersonal data given to Bido Media, Inc. may be transferred across state and country borders for the purposes of data consolidation, storage and simplified customer information management. By using Bido Media, Inc. Services or providing any personal information to us, where applicable law permits, you consent to the transfer, processing, and storage of such information outside of your country of residence where data protection standards may be different.'),
                  TextSpan(
                      text: '\n \n ACCESS & ACCURACY',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          "\nBido Media, Inc. strives to keep your personally identifiable information accurate. We have put in place managerial data standards review processes and technological tools to maintain customer data accuracy. We will provide you with access to view and change your information, including making every effort to provide you with online access. To protect your privacy and security, we will also take reasonable steps to verify your identity, such as a password and user ID, before granting access to your data. Certain areas of EQUEUE.APP's web sites may limit access to specific individuals through the use of passwords and other personal identifiers."),
                  TextSpan(
                      text: '\n \n SECURITY',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          '\nBido Media, Inc. strives to ensuring the safety and security of your information. To prevent unauthorized access or disclosure, maintain data accuracy and ensure the appropriate use of the information, EQUEUE.APP has in place appropriate physical, managerial procedures to safeguard the information we collect.'),
                  TextSpan(
                      text: '\n \n EQUEUE.APP RIGHT',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          '\n \n YOU ACKNOWLEDGE AND AGREE THAT Bido Media, Inc. HAS THE RIGHT TO DISCLOSE YOUR PERSONAL INFORMATION TO ANY LEGAL, REGULATORY, GOVERNMENTAL, TAX, LAW ENFORCEMENT OR OTHER AUTHORITIES OR THE RELEVANT RIGHT OWNERS, IF Bido Media, Inc. HAS REASONABLE GROUNDS TO BELIEVE THAT DISCLOSURE OF YOUR PERSONAL INFORMATION IS NECESSARY FOR THE PURPOSE OF MEETING ANY OBLIGATIONS, REQUIREMENTS OR ARRANGEMENTS, WHETHER VOLUNTARY OR MANDATORY, AS A RESULT OF COOPERATING WITH AN ORDER, AN INVESTIGATION AND/OR A REQUEST OF ANY NATURE BY SUCH PARTIES. TO THE EXTENT PERMISSIBLE BY APPLICABLE LAW, YOU AGREE NOT TO TAKE ANY ACTION AND/OR WAIVE YOUR RIGHTS TO TAKE ANY ACTION AGAINST Bido Media, Inc. FOR THE DISCLOSURE OF YOUR PERSONAL INFORMATION IN THESE CIRCUMSTANCES.',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: '\n \n BIDO MEDIA INC. ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          'reserves the right to change, modify or amend the terms and conditions herein at its own discretion and without prior notice.'),
                ]),
          ),
        ),
      ),
    );
  }
}
