from flask import Flask, render_template, request, redirect, url_for, flash
from flask_mail import Mail, Message

app = Flask(__name__)
app.secret_key = "supersecretkey"  # needed for flash messages

# Configure Flask-Mail
app.config['MAIL_SERVER'] = 'smtp.gmail.com'
app.config['MAIL_PORT'] = 465
app.config['MAIL_USE_SSL'] = True
app.config['MAIL_USERNAME'] = 'rajesh.singh@cardekho.com'  # your email
app.config['MAIL_PASSWORD'] = 'Girnar@#25'  # ⚠️ Use app password, not real password!

mail = Mail(app)

# Home page
@app.route("/", methods=["GET", "POST"])
def index():
    if request.method == "POST":
        name = request.form.get("name")
        email = request.form.get("email")
        message_body = request.form.get("message")

        msg = Message(
            subject=f"New Contact Form Submission from {name}",
            sender=app.config['MAIL_USERNAME'],
            recipients=['rajesh.singh@cardekho.com'],
            body=f"Name: {name}\nEmail: {email}\nMessage:\n{message_body}"
        )

        try:
            mail.send(msg)
            flash("✅ Thank you for contacting us! Your message has been sent.", "success")
        except Exception as e:
            flash(f"❌ Error sending message: {e}", "danger")

        return redirect(url_for("index"))

    return render_template("index.html")


if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=5000)

