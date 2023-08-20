import imaplib
import email
from email.header import decode_header
import openpyxl

# Connect to the email server
mail = imaplib.IMAP4_SSL("imap.gmail.com")


# Log in to your email account
mail.login('amanskes@gmail.com', 'ksakgzhtvnxtzuqf')

# Select the "INBOX" mailbox
mail.select("inbox")

# Get user input for the sender's email address
sender_email = input("Enter the sender's email address: ")

# Search for emails from the specified sender
search_query = f'FROM "{sender_email}"'
status, email_ids = mail.search(None, search_query)

email_ids = email_ids[0].split()

# Create a new Excel workbook and sheet
workbook = openpyxl.Workbook()
sheet = workbook.active
sheet.append(["Subject", "From", "Date"])

for email_id in email_ids:
    status, msg_data = mail.fetch(email_id, "(RFC822)")

    msg = email.message_from_bytes(msg_data[0][1])

    # Extract email information
    subject, encoding = decode_header(msg["Subject"])[0]
    if isinstance(subject, bytes):
        subject = subject.decode(encoding if encoding else "utf-8")

    from_ = msg.get("From")
    date = msg.get("Date")

    content = ""
    if msg.is_multipart():
        for part in msg.walk():
            if part.get_content_type() == "text/plain":
                content += part.get_payload(decode=True).decode("utf-8")
    else:
        content = msg.get_payload(decode=True).decode("utf-8")

    sheet.append([subject, from_, date, content])

# Save the Excel file
file_name = f"email_information_{sender_email}.xlsx"
workbook.save(file_name)

print(f"Emails from {sender_email} saved in {file_name}")

# Logout from the server
mail.logout()
