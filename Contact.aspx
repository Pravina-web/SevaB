<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="Seva_Bureau.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
      <style>
        @media (max-width: 576px) {
    .input-group-text {
        font-size: 0.85rem;
        padding: 0.375rem 0.5rem;
    }

    .form-control::placeholder {
        font-size: 0.85rem;
    }
}

    </style>
    <main class="py-5">
        <div class="container">
            <div class="d-flex justify-content-center align-items-center" style="min-height: 80vh;">
                <div class="col-12 col-md-8 col-lg-6">

                    <asp:Panel ID="pnlContactForm" runat="server" CssClass="p-4 border rounded shadow bg-light">
                        <h2 class="text-center text-primary fw-bold mb-4">
                            <i class="fa-solid fa-envelope"></i> Contact Us
                        </h2>

                        <!-- Name Field -->
                        <div class="mb-3">
                            <label for="txtName" class="form-label fw-bold">
                                <i class="fa-solid fa-user"></i> Name: <span class="text-danger">*</span>
                            </label>
                           <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter your name"
    onblur="validateName()" oninput="filterNameInput(this)"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName"
                                ErrorMessage="" ForeColor="Red" Display="Dynamic"
                                SetFocusOnError="true" EnableClientScript="true" />
                            <asp:RegularExpressionValidator ID="revName" runat="server" ControlToValidate="txtName"
                                ValidationExpression="^[a-zA-Z\s]{2,}$"
                                ErrorMessage="❌ Enter at least 2 letters (no special characters)!"
                                ForeColor="Red" Display="Dynamic" />
                        </div>
                        <div id="nameError" class="text-danger fw-bold" style="display:none;"></div>
                        <!-- Mobile Field -->
                        <div class="mb-3">
                            <label for="txtMobile" class="form-label fw-bold">
                                <i class="fa-solid fa-phone"></i> Mobile: <span class="text-danger">*</span>
                            </label>
               <div class="input-group">
    <span class="input-group-text">+91</span>
    <div class="flex-grow-1">
        <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control w-100" MaxLength="10"
            placeholder="Enter 10-digit mobile number" TextMode="SingleLine"
            onblur="validateMobile()" oninput="filterMobileInput(this)"></asp:TextBox>
    </div>
</div>

                            <asp:RequiredFieldValidator ID="rfvMobile" runat="server" ControlToValidate="txtMobile"
                                ErrorMessage="" ForeColor="Red" Display="Dynamic"
                                SetFocusOnError="true" EnableClientScript="true" />
                            <asp:RegularExpressionValidator ID="revMobile" runat="server" ControlToValidate="txtMobile"
                                ValidationExpression="^\d{10}$"
                                ErrorMessage="❌ Enter a valid 10-digit mobile number!"
                                ForeColor="Red" Display="Dynamic" />
                        </div>
                        <div id="mobileError" class="text-danger fw-bold" style="display:none;"></div>

                        <!-- Email Field -->
                       <div class="mb-3">
    <label for="txtEmail" class="form-label fw-bold">
        <i class="fa-solid fa-envelope"></i> Email:
    </label>
    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"
        TextMode="Email" placeholder="Enter your email"
        oninput="validateEmail()" onblur="validateEmail()"></asp:TextBox>

    <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
        ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
        ErrorMessage="❌ Enter a valid email address!"
        ForeColor="Red" Display="Dynamic" />

    <!-- Client-side error placeholder -->
    <div id="emailError" class="text-danger fw-bold" style="display:none;"></div>
</div>


                        <!-- Message Field -->
                        <div class="mb-3">
                            <label for="txtMessage" class="form-label fw-bold">
                                <i class="fa-solid fa-comment"></i> Message:
                            </label>
                            <asp:TextBox ID="txtMessage" runat="server" CssClass="form-control"
                                TextMode="MultiLine" Rows="4" placeholder="Type your message"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="revMessage" runat="server" ControlToValidate="txtMessage"
                                ValidationExpression="^[a-zA-Z0-9\s]+$"
                                ErrorMessage="❌ Only letters and numbers allowed!"
                                ForeColor="Red" Display="Dynamic" />
                        </div>

                         <!-- Hidden reCAPTCHA token field -->
                        <input type="hidden" id="g-recaptcha-response" name="g-recaptcha-response" />

                        <!-- Submit Button -->
                        <div class="d-grid mt-4">
                            <asp:Button ID="btnSubmit" runat="server" Text="Submit"
                                CssClass="btn btn-primary rounded-pill" OnClick="btnSubmit_Click" />
                        </div>

                        <!-- Feedback Message -->
                        <div class="text-center mt-3">
                            <asp:Label ID="lblMessage" runat="server" CssClass="fw-bold text-success" Visible="false"></asp:Label>
                        </div>
                    </asp:Panel>
                </div>
            </div>
        </div>
    </main>
     <!-- reCAPTCHA v3 Script -->
    <script src="https://www.google.com/recaptcha/api.js?render=6LfWVzcrAAAAAJ-OhvFOyxQXyiTesbg0-KMAZsmY"></script>
    <script>
        grecaptcha.ready(function () {
            grecaptcha.execute('6LfWVzcrAAAAAJ-OhvFOyxQXyiTesbg0-KMAZsmY', { action: 'submit' }).then(function (token) {

                document.getElementById('g-recaptcha-response').value = token;
            });
        });
    </script>
    <script type="text/javascript">
        function filterNameInput(input) {
            input.value = input.value.replace(/[^a-zA-Z\s]/g, '');
        }

        function filterMobileInput(input) {
            input.value = input.value.replace(/[^0-9]/g, '');
        }

        function validateName() {
            const nameField = document.getElementById('<%= txtName.ClientID %>');
        const name = nameField.value.trim();
        const error = document.querySelector("#nameError");

        if (!name || name.length < 0) {
            error.innerText = "Name is required!";
            error.style.display = "block";
        } else {
            error.style.display = "none";
        }
    }

        function validateMobile() {
            const mobileField = document.getElementById('<%= txtMobile.ClientID %>');
            const mobile = mobileField.value.trim();
            const error = document.querySelector("#mobileError");

            if (mobile === "") {
                error.innerText = "Mobile number is required!";
                error.style.display = "block";
            } else if (!/^\d{10}$/.test(mobile)) {
                error.innerText = "Please enter a valid 10-digit number.";
                error.style.display = "block";
            } else {
                error.style.display = "none";
            }
        }

        function validateEmail() {
            const emailField = document.getElementById('<%= txtEmail.ClientID %>');
            const email = emailField.value.trim();
            const error = document.getElementById('emailError');
            const emailPattern = /^[^@\s]+@[^@\s]+\.[^@\s]+$/;

            if (email && !emailPattern.test(email)) {
                error.innerText = "❌ Enter a valid email address !";
                error.style.display = "block";
            } else {
                error.style.display = "none";
            }
        }
    </script>
   
</asp:Content>
