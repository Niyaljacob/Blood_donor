import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart'; // Use this for the @riverpod annotation
part 'mail_repository.g.dart';
class MailRepository {
  Future<void>sendEmail({
    required String donorEmail,
    required String recipientEmail,
        required String recipientName,
    required String recipientPhone,
    required String recipientBloodGroup,
  })async{
    const String username= 'niyaljacob76@gmail.com';
    const String password='kxvw tqho pbmj cvbu';

    final smtpServer = gmail(username, password);

    final message = Message()
    ..from = const Address(username, 'Blood Donation App')
    ..recipients.add(donorEmail)
    ..subject = 'Blodd donation request from $recipientName'
    ..text=
    "Hello, $recipientName is requested a blood donation. Details:\n\n"
    "Name: $recipientName\n"
    "phone: $recipientPhone\n"
    "Email: $recipientEmail\n"
    "Blood Group: $recipientBloodGroup\n\n"
    "Kindly reach out. Thanku you!"
    ..html = '<h1>Blood Donation Request</h1>'
    '<p><strong>Name:</strong> $recipientName</p>'
    '<p><strong>phone:</strong> $recipientPhone</p>'
    '<p><strong>Email:</strong> $recipientEmail</p>'
    '<p><strong>Blood Group:</strong> $recipientBloodGroup</p>';

    try{
      await send(message, smtpServer);

    }on MailerException catch(e){
      throw Exception('Failed to send email: ${e.message}');
    }
  }
}

@riverpod
MailRepository mailRepository (MailRepositoryRef ref){
  return MailRepository();
}