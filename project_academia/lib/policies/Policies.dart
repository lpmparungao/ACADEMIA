import 'package:flutter/material.dart';
import 'package:sample1/SignUp.dart';


class Policies extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Row(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: 80),
            Text(
              'Policies',
              style: TextStyle(color: Colors.black, fontSize: 24),
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUp()),
            );
            //Navigator.pop(context);
          },
        ),
      elevation: 0,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      ),
      body: Container(
        child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Center(
                child: Text('Terms and Conditions ("Terms")',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Center(
                child: Text('Last updated: July 24, 2021' + '\n' + '\n' +
                  'Please read these Terms and Conditions ("Terms", "Terms and Conditions")' + 
                  ' carefully before using the Academia mobile application operated by Tech Intellect. ' + 
                  'Your access to and use of the Service is conditioned on your acceptance of and compliance with these Terms. ' + 
                  'These Terms apply to all visitors, users and others who access or use the Service. By using or accessing Academia, ' + 
                  'regardless of you whether have registered to use any of the services offered on the application, ' + 
                  'you signify that you have read and understood these Terms and Conditions and agree to be bound by the same.',
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0,right: 25.0, bottom: 25.0),
              child: Center(
                child: Text('By accessing or using Academia, you agree to be bound by these Terms. ' + 
                'If you disagree with any part of the terms, then you may not access Academia.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0,right: 25.0,),
              child: Center(
                child: Text('Eligibility',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Center(
                child: Text('Persons under the age of 13 are not permitted to use this application. ' + 
                'Tech Intellect has the right to reject the use of the application when the information ' + 
                'regarding the age of the user is proved to be untrue.',
                textAlign: TextAlign.justify,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0,right: 25.0,),
              child: Center(
                child: Text('Restrictions on Use',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0,right: 25.0,top: 25.0),
              child: Center(
                child: Text('You agree to abide by all applicable terms and conditions, law and regulations in your ' + 
                'use of the application. In addition, you agree that you will not do any of the following:',
                textAlign: TextAlign.justify,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40.0,right: 25.0,bottom: 25.0),
              child: Center(
                child: Text('\n' + '•	register for more than one account, or register for an account on behalf of an individual other ' + 
                'than yourself or on behalf of any group or entity;' + '\n' + '•	take any action on the application, ' + 
                'that may constitute libel or slander or that infringes or violates someone else’s rights or is protected ' + 
                'by any copyright or trademark, or otherwise violates the law;' + '\n' + 
                '•	use the information or content on the application to send unwanted messages to any other user;' + '\n' +
                '•	impersonate any person or entity, or falsely state or otherwise misrepresent yourself, ' + '\n' + 
                'your age or your affiliation with any person or entity;' + '\n' + 
                '•	use the application or our products and services in any manner that could damage, disable, overburden ' + '\n' + 
                'or impair the application;' + '\n' + '•	harvest or collect email addresses or other contact information of ' + '\n' + 
                'other users from the application by electronic or other means, including the use of automated scripts; or' + '\n' + 
                '•	post or otherwise make available any material that contains software viruses or any other computer code, ' +  
                'files or programs designed to interrupt, destroy or limit the functionality of any computer software or hardware or telecommunications equipment.',
                textAlign: TextAlign.justify,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0,right: 25.0,),
              child: Center(
                child: Text('Registration and Application',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Center(
                child: Text('In creating your account, you agree to provide the true, current, complete, and accurate information ' + 
                'in the registration or application form which is necessary for purposes of using our application. If any information ' + 
                'you provide is untrue, inaccurate, not current, or incomplete, we reserve the right to cancel your registration, ' + 
                'and restrict your future use of this application. Tech Intellect also reserves the right to reject any registration, ' + 
                'deny access to the application in violation of these Terms and Conditions. ' + '\n' + 'You agree that Academia may, ' + 
                'at its sole discretion, use digital signatures to sign any documents, or any other electronic means to confirm consent ' + 
                'and validation of your account.',
                textAlign: TextAlign.justify,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0,right: 25.0,),
              child: Center(
                child: Text('Collection and use of Personal Information',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Center(
                child: Text('It is important for you to know that the application can only be used if you agree to disclose ' + 
                'relevant personal information which may verified by Tech Intellect, on your behalf, from all relevant sources.',
                textAlign: TextAlign.justify,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0,right: 25.0,),
              child: Center(
                child: Text('Links To Other Web Sites',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Center(
                child: Text('Our Service may contain links to third-party web sites or services that are not owned or controlled ' + 
                'by Academia.' + '\n' + '\n' + 'Tech Intellect has no control over, and assumes no responsibility for, the content, privacy policies, ' + 
                'or practices of any third-party web sites or services. You further acknowledge and agree that Tech Intellect shall ' + 
                'not be responsible or liable, directly or indirectly, for any damage or loss caused or alleged to be caused by or ' + 
                'in connection with use of or reliance on any such content, goods or services available on or through any such web ' + 
                'sites or services',
                textAlign: TextAlign.justify,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0,right: 25.0,),
              child: Center(
                child: Text('Changes',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Center(
                child: Text('We reserve the right, at our sole discretion, to modify or replace these Terms at any time. ' + 
                'If a revision is material, we will try to provide at least 10 days notice prior to any new terms taking effect. ' + 
                'What constitutes a material change will be determined at our sole discretion.',
                textAlign: TextAlign.justify,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0,right: 25.0,),
              child: Center(
                child: Text('Contact Us',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Center(
                child: Text('If you have any questions about these Terms, please contact us through email.' + '\n' + 
                'Email Address: academia_care@gmail.com',
                textAlign: TextAlign.justify,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0,right: 25.0,),
              child: Center(
                child: Text('Acceptance',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Center(
                child: Text('YOU CONFIRM HAVING READ AND UNDERSTOOD AND AGREE TO THE FOREGOING ' + 
                'TERMS AND CONDITIONS. BY ACCEPTING THESE TERMS AND CONDITIONS, AND THE PRIVACY POLICY, YOU SIGNIFY YOUR EXPRESS ' + 
                'CONSENT IN ACCORDANCE WITH REPUBLIC ACT NO. 10173, OTHERWISE REFERRED TO AS THE DATA PRIVACY ACT OF 2012 AND ITS ' + 
                'IMPLEMENTING RULES AND REGULATIONS AS WELL AS OTHER APPLICABLE CONFIDENTIALITY AND DATA PRIVACY LAWS OF THE PHILIPPINES. ' + 
                'YOU AGREE TO HOLD THE COMPANY, ITS OFFICERS, DIRECTORS AND STOCKHOLDERS, FREE AND HARMLESS FROM ANY AND ALL LIABILITIES, ' + 
                'DAMAGES, ACTIONS, CLAIMS, AND SUITS IN CONNECTION WITH THE IMPLEMENTATION OR PROCESSING OF PERSONAL INFORMATION IN ' + 
                'RELATION TO YOUR CONSENT OR AUTHORIZATION UNDER THESE TERMS AND CONDITIONS.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }
}
