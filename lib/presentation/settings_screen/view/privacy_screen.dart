import 'package:flutter/material.dart';
import 'package:FloBeat/core/constant/Textstyle.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy and policy"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Privacy Policy for music player",
                style: heading(),
              ),
              Text("\nLast updated: June 25, 2024"),
              Text(
                  "\nThis Privacy Policy describes Our policies and procedures on the collection, use and disclosure of Your information when You use the Service and tells You about Your privacy rights and how the law protects You."),
              Text(
                  "\nWe use Your Personal data to provide and improve the Service. By using the Service, You agree to the collection and use of information in accordance with this Privacy Policy. This Privacy Policy has been created with the help of the Privacy Policy Generator."),
              Text("\nInterpretation and Definitions", style: heading()),
              Text(
                "\nInterpretation",
                style: subheading(),
              ),
              Text(
                  "\nThe words of which the initial letter is capitalized have meanings defined under the following conditions. The following definitions shall have the same meaning regardless of whether they appear in singular or in plural."),
              Text(
                "\nDefinitions",
                style: subheading(),
              ),
              Text("\nFor the purposes of this Privacy Policy:"),
              Text(
                  "\nAccount means a unique account created for You to access our Service or parts of our Service."),
              Text(
                  "\nAffiliate means an entity that controls, is controlled by or is under common control with a party, where control means ownership of 50% or more of the shares, equity interest or other securities entitled to vote for election of directors or other managing authority."),
              Text(
                  "\nApplication refers to music player, the software program provided by the Company."),
              Text(
                  "\nCompany (referred to as either the Company, We, Us, or Our, in this Agreement) refers to music player.}"),
              Text("\nCountry refers to: Kerala, India"),
              Text(
                  "\nDevice means any device that can access the Service such as a computer, a cellphone or a digital tablet."),
              Text(
                  "\nPersonal Data is any information that relates to an identified or identifiable individual."),
              Text("\nService refers to the Application."),
              Text(
                  "\nService Provider means any natural or legal person who processes the data on behalf of the Company. It refers to third-party companies or individuals employed by the Company to facilitate the Service, to provide the Service on behalf of the Company, to perform services related to the Service or to assist the Company in analyzing how the Service is used."),
              Text(
                  "\nUsage Data refers to data collected automatically, either generated by the use of the Service or from the Service infrastructure itself (for example, the duration of a page visit)."),
              Text(
                  "\nYou means the individual accessing or using the Service, or the company, or other legal entity on behalf of which such individual is accessing or using the Service, as applicable."),
              Text("\nCollecting and Using Your Personal Data",
                  style: heading()),
              Text(
                "\nTypes of Data Collected",
                style: subheading(),
              ),
              Text(
                "\nPersonal Data",
                style: subheading(),
              ),
              Text(
                  "\nWhile using Our Service, We may ask You to provide Us with certain personally identifiable information that can be used to contact or identify You. Personally identifiable information may include, but is not limited to:"),
              Text("\nUsage Data"),
              Text(
                "\nUsage Data",
                style: subheading(),
              ),
              Text(
                  "\nUsage Data is collected automatically when using the Service."),
              Text(
                  "\nUsage Data may include information such as Your Device's Internet Protocol address (e.g. IP address), browser type, browser version, the pages of our Service that You visit, the time and date of Your visit, the time spent on those pages, unique device identifiers and other diagnostic data."),
              Text(
                  "\nWhen You access the Service by or through a mobile device, We may collect certain information automatically, including, but not limited to, the type of mobile device You use, Your mobile device unique ID, the IP address of Your mobile device, Your mobile operating system, the type of mobile Internet browser You use, unique device identifiers and other diagnostic data."),
              Text(
                  "\nWe may also collect information that Your browser sends whenever You visit our Service or when You access the Service by or through a mobile device."),
              Text(
                "\nSecurity of Your Personal Data",
                style: subheading(),
              ),
              Text(
                  "\nThe Company may use Personal Data for the following purposes:"),
              Text(
                  "\nThe security of Your Personal Data is important to Us, but remember that no method of transmission over the Internet, or method of electronic storage is 100% secure. While We strive to use commercially acceptable means to protect Your Personal Data, We cannot guarantee its absolute security."),
              Text("\nChildren's Privacy", style: heading()),
              Text(
                  "\nOur Service does not address anyone under the age of 13. We do not knowingly collect personally identifiable information from anyone under the age of 13. If You are a parent or guardian and You are aware that Your child has provided Us with Personal Data, please contact Us. If We become aware that We have collected Personal Data from anyone under the age of 13 without verification of parental consent, We take steps to remove that information from Our servers."),
              Text(
                  "\nIf We need to rely on consent as a legal basis for processing Your information and Your country requires consent from a parent, We may require Your parent's consent before We collect and use that information."),
              Text("\nChanges to this Privacy Policy", style: heading()),
              Text(
                  "\nWe may update Our Privacy Policy from time to time. We will notify You of any changes by posting the new Privacy Policy on this page."),
              Text(
                  "\nWe will let You know via email and/or a prominent notice on Our Service, prior to the change becoming effective and update the ${"Last updated"} date at the top of this Privacy Policy."),
              Text(
                  "\nYou are advised to review this Privacy Policy periodically for any changes. Changes to this Privacy Policy are effective when they are posted on this page."),
              Text("\nContact Us", style: heading()),
              Text(
                  "\nIf you have any questions about this Privacy Policy, You can contact us:"),
              Text("\nBy email: choisonshaju007@gmail.com"),
            ],
          ),
        ),
      ),
    );
  }
}
