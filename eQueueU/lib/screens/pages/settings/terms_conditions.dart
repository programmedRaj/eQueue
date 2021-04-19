import 'package:flutter/material.dart';

class TermsCondition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Terms&Condition',
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
                style: TextStyle(
                    color: Theme.of(context).accentColor, fontSize: 18),
                children: [
                  TextSpan(
                      text: 'eQueue.app is a product of Bido Media Inc.\n \n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: 'eQueue Terms of Use\n \n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          'Bido Media Inc. (“e-Queue,” “equeue.app,” “our,” “we,” or “us”) provide token (or number) for services which provide by companies to their clients or customers via equeue mobile app. Please read our terms of service so you understand what’s up with your use of our product “equeue.” You agree to our terms of services (“Terms”) by installing, accessing or using our apps, services, features. Software or website (“together our “Services.”)\n\n'),
                  TextSpan(
                      text:
                          'The following terms and conditions ("Terms and Conditions") apply to your access and use of this Website and electronic queue management system service ("Service") provided herein by "Bido Meida Inc" (equeue.app and/or eQueue) and/or on its behalf. By accessing any page of this Website and/or using the services, you agree to be bound by these Terms and Conditions without limitation or qualification. Please read these Terms and Conditions carefully.\n If you do not accept these Terms and Conditions, please discontinue your access to this Website and/or use of the services immediately.\n'),
                  TextSpan(
                      text: '\n GENERAL\n\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          'All products and services of the BIDO MEDIA INC are subject to the applicable terms and conditions governing the products and/or services. Please check the applicable terms and conditions of sale associated with the products and/or services you may purchase. These Terms and Conditions are meant to regulate your access to this Website and they are to be read together with the applicable terms and conditions governing any transaction(s), product(s) and/or service(s) provided on this Website. In the event of conflict between these Terms and Conditions and the terms and conditions governing the relevant transaction(s), product(s) and/or service(s) provided herein, the latter would prevail. \n The information, material, functions and content provided in the pages of the Website may be changed from time to time with or without notice at BIDO MEDIA INC absolute discretion. Your continued access or use of the Website and/or the services provided herein subsequent to any such change will be deemed as your acceptance to those changes.\n\n'),
                  TextSpan(text: 'DISCLAIMER\n'),
                  TextSpan(
                      text:
                          '\nThe materials may contain inaccuracies and typographical errors. BIDO MEDIA INC does not warrant the accuracy or completeness of the materials or the reliability of any advice, opinion or other information display or distributed through EQUEUE.APP. You acknowledge that any reliance on any such advise, opinion or information shall be at your sole risk. BIDO MEDIA INC. reserves the right, in its sole discretion to correct any errors or omissions in any portion of the site. BIDO MEDIA INC. may make any changes to the site at any time without notice.'),
                  TextSpan(
                      text:
                          '\n \n The materials in equeue.app are provided “As Is” and without warranties of any kind either expressed or implied to the fullest extent permissible pursuant to applicable law. By using EQUEUE APP you agree to indemnify, defend and hold BIDO MEDIA INC., BIDO MEDIA INC. and all affiliated partners harmless against any claims (including, but not limited to, claims for defamation, trade disparagement, privacy and intellectual property infringement) and damages including attorney’s fees arising from any submissions by you or through your account.'),
                  TextSpan(
                      text: '\n \n SPECIFIC SERVICE RULES',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          '\n As a user you agree not to do any of the following:-'),
                  TextSpan(
                      text:
                          '\nAbuse, harass, threaten, stalk, defame or in anyway seek to violate the rights of another user or third liarty.'),
                  TextSpan(
                      text:
                          '\nPublish or seek to distribute any material or information that is unlawful, harmful, obscene, indecent, libellous, profane, defamatory, racist, or in any other way inappropriate or objectionable.'),
                  TextSpan(
                      text:
                          '\nAttempt to gain access to our servers or other equipment in order to disrupt, impair, overload or otherwise hinder or compromise the safety, security or privacy of any of the services provided by or relied upon by us and users.'),
                  TextSpan(
                      text:
                          '\nTo transmit or transfer any viruses, trojans, worms or any other malicious programs or code intended to spy on, gain control over, disrupt, destroy or in any other way impair any computer hardware or software or any other equipment.'),
                  TextSpan(
                      text:
                          '\nUse any robot, spider, scraper or other technical means to access the Service or any content on the Service.'),
                  TextSpan(
                      text:
                          '\nPosting URLs to external websites or any form of HTML or programming code'),
                  TextSpan(
                      text:
                          '\nPosting anything that may be “spam,” as determined by foodpanda in its sole discretion'),
                  TextSpan(
                      text:
                          '\nPosting Content that constitutes cyber-bullying, as determined by BIDO MEDIA INC. in its sole discretion'),
                  TextSpan(
                      text:
                          '\nPosting Content that depicts any dangerous, life-threatening, or otherwise risky behavior'),
                  TextSpan(
                      text:
                          '\nPosting telephone numbers, street addresses, or names of any person'),
                  TextSpan(
                      text:
                          '\nPosting Content that is unlawful, obscene, defamatory, threatening, harassing, abusive, slanderous, hateful, or embarrassing to any other person or entity as determined by foodpanda in its sole discretion or pursuant to local community standards'),
                  TextSpan(
                      text:
                          '\nPosting Content that infringes the intellectual property rights, privacy rights, publicity rights, trade secret rights, or any other rights of any party'),
                  TextSpan(
                      text:
                          '\nHarvesting or otherwise collecting information about others, including e-mail addresses, without their consent\nAllowing any other person or entity to use your identification for posting or viewing comments\nHarassing, threatening, stalking, or abusing any person \nYou may not use, copy, reproduce, republish, upload, post, transmit, distribute, or modify these Copyright in any way. \n'),
                  TextSpan(
                      text: '\n \n ACCOUNTS',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          '\n \n You may be required to create an account with email or phone number or username to use certain features on the EQUEUE  mobile application. You agree to provide, maintain and update true, accurate, current and complete information about yourself as prompted by the registration processes. You may not impersonate any person or entity or misrepresent your identity or affiliation with any person or entity, including using another person’s username, password, or other account information.'),
                  TextSpan(
                      text: '\n \n FREE VERSION',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          '\n \n BIDO MEDIA INC. reserve the right to cancel or delete your account at any time for reasons including if fraud or an unauthorized or illegal activities are suspected. The accuracy of the data might be inaccurate.'),
                  TextSpan(
                      text: '\n \n SUBSCRIPTIONS',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          '\n\n Services are billed on a subscription basis. A valid payment method, including credit card or PayPal, is required to process the payment for your Subscription. You shall provide BIDO MEDIA INC. with accurate and complete billing information including full name, address, state, zip code, telephone number, and a valid payment method information. By submitting such payment information, you automatically authorize BIDO MEDIA INC. to charge all Subscription fees incurred through your account to any such payment instruments.'),
                  TextSpan(text: '\n \nFor iOS subscriber:-'),
                  TextSpan(
                      text:
                          "\n \n Payment will be charged to iTunes Account at confirmation of purchase \nSubscription automatically renews unless auto-renew is turned off at least 24-hours before the end of the current period \nAccount will be charged for renewal within 24-hours prior to the end of the current period \nSubscriptions may be managed by the user and auto-renewal may be turned off by going to the user's Account Settings after purchase \n"),
                  TextSpan(
                      text: '\n \n CANCELLATION',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          '\n \n BIDO MEDIA INC. allows to cancel the subscriptions or orders anytime. Paid Subscription fees or orders are non-refundable.'),
                  TextSpan(
                      text: '\n \n PAYMENT',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          '\n \n Cash, Visa, Mastercard, American Express, online banking, PayPal. The provider reserves the right to provide other payment methods or to no longer offer certain payment methods. The end customer bindingly chooses the payment method when placing the respective order. Provided that the end customer chooses an online payment method, the payment might be processed by an external payment provider cooperating with the provider. Card data will in this case be stored for future orders by the payment provider, on the condition that the end customer chooses the respective storage of such and hereby gives consent to it.'),
                  TextSpan(
                      text: '\n \n TERMINATION',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          '\nBIDO MEDIA INC. has the right to terminate your account and access to BIDO MEDIA INC. for any reason, including, without limitation, if BIDO MEDIA INC., in its sole discretion, considers your use to be unacceptable, or in the event of any breach by you of the Terms of Use. BIDO MEDIA INC. may, but shall be under no obligation to, provide you a warning prior to termination of your use of EQUEUE.'),
                  TextSpan(
                      text: '\n \n HYPERLINKS',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          '\nEQUEUE may contain hyperlinks to third-party websites. BIDO MEDIA INC. does not control or endorse these third-party websites or any goods or services sold on those websites. Some of these websites may contain materials that are objectionable, unlawful, or inaccurate. You acknowledge and agree that BIDO MEDIA INC. is not responsible or liable for any Content or other materials on these third party websites.'),
                  TextSpan(
                      text: '\n \n INTERNET DELAYS',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          '\nThe service, the application and/or the software may be subject to limitations, delays, and other problems inherent in the use of the internet and electronic communications including the device used by you or the third party device provider being faulty, not connected, out of range, switched off or not functioning. The company is not responsible for any delays, delivery failures, damages or losses resulting from such problems.'),
                  TextSpan(
                      text: '\n \n NOTICE',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          '\nBIDO MEDIA INC. may give notice by means of a general notice on the Application, electronic mail to your email address in the records of EQUEUE'),
                  TextSpan(
                      text: '\n \n GOVERNING LAW AND SEVERABILITY',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          '\nThese Terms of Use shall be governed by and construed in accordance with the laws of Malaysia, without regard to its conflict of laws rules. You expressly agree that the exclusive jurisdiction for any claim or dispute under the Terms of Use and or your use of the Websites resides in the courts of Malaysia, and you further expressly agree to submit to the personal jurisdiction of such courts for the purpose of litigating any such claim or action.\nIf any provision of these Terms of Use is found to be invalid by any court having competent jurisdiction, the invalidity of such provision shall not affect the validity of the remaining provisions of these Terms of Use, which shall remain in full force and effect. No waiver of any provision in these Terms of Use shall be deemed a further or continuing waiver of such provision or any other provision.'),
                  TextSpan(
                      text: '\n \n WARRANTIES',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          '\nThe BIDO MEDIA INC. Entities, their agents, representatives and service providers cannot and do not guarantee or warrant that: \n EQUEUE will be reliable, accurate, complete, or updated on a timely basis \n EQUEUE will be free of human and machine errors, omissions, delays, interruptions or losses, including loss of data \n Any files available for downloading from EQUEUE.APP will be free of infection by viruses, worms, Trojan horses, or other codes that manifest contaminating or destructive properties  \n  Any Content you post on EQUEUE.APP will remain on EQUEUE.APP or the functions or services performed on EQUEUE.APP will be uninterrupted or error-free or that defects in EQUEUE.APP will be corrected.'),
                  TextSpan(
                      text: '\n \n LIMITATION OF LIABILITY',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          "\n Because some states or jurisdictions do not allow the exclusion or the limitation of liability for consequential or incidental damages, in such states or jurisdictions, the BIDO MEDIA INC.  entities, their agents, representatives and service providers' liability shall be limited to the extent permitted by law."),
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
