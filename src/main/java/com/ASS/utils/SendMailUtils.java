package com.ASS.utils;

import jakarta.mail.Authenticator;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.util.Properties;

public class SendMailUtils {
    public static void sendMail(String pass,String from,String to,String subject,String body) {
        Properties props = new Properties();
        // SMTP -> Simple mail transfer protocol
        props.setProperty("mail.smtp.auth","true");
        props.setProperty("mail.smtp.starttls.enable","true");
        props.setProperty("mail.smtp.host", "smtp.gmail.com");
        props.setProperty("mail.smtp.port", "587");
        props.put("mail.debug", "true");

        //LOGIN GMAIL
        Session session = Session.getInstance(props,new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                String username = from;
                String password = pass;
                return new PasswordAuthentication(username, password);
            }
        });

        // CREATE MAIL
        try {
            MimeMessage mail = new MimeMessage(session);
            mail.setFrom(new InternetAddress(from));

            // Split the "to" field into multiple addresses
            String[] recipients = to.split(",");
            for (String recipient : recipients) {
                mail.addRecipient(MimeMessage.RecipientType.TO, new InternetAddress(recipient.trim()));
            }

            mail.setSubject(subject, "utf-8");
            mail.setContent(body, "text/html; charset=utf-8");
            mail.setReplyTo(mail.getFrom());

            // SEND MAIL
            Transport.send(mail);
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("Da chay xong sendEmail");
    }
}
