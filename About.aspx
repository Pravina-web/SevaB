<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="Seva_Bureau.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container my-5">
        <div class="row">
            <!-- Sidebar Navigation -->
            <div class="col-md-3 mb-4">
                <nav class="list-group shadow-sm">
                    <a href="javascript:void(0);" onclick="loadContent('about')" id="about-link" class="list-group-item list-group-item-action">About Us</a>
                    <a href="javascript:void(0);" onclick="loadContent('vision')" id="vision-link" class="list-group-item list-group-item-action">Vision</a>
                    <a href="javascript:void(0);" onclick="loadContent('mission')" id="mission-link" class="list-group-item list-group-item-action">Mission</a>
                </nav>
            </div>

            <!-- Main Content -->
            <div class="col-md-9">
                <div id="contentArea" class="p-4 bg-light rounded shadow-sm">
                 
                </div>
            </div>
        </div>
    </div>

    <script>
        function loadContent(section) {
            const content = {
                'about': `
                    <h2>About Us</h2>
                    <p>Our journey began with a personal experience. In August 2021, our grandmother suffered a stroke that left her bedridden. As family members, we often felt helpless, unsure of how to provide the best care for her.</p>
                    <p>Through this experience, we realized that many families face the same challenges—wanting the best for their loved ones but lacking the time, knowledge, or resources to provide the necessary care. This understanding inspired us to establish Shree Samarth Seva Bureau, a service dedicated to helping families find reliable and trained caregivers for their bedridden or elderly members.</p>
                    <p>Having personally gone through this journey, we are deeply committed to ensuring that every patient receives the utmost care, dignity, and comfort.</p>
                `,
                'vision': `
                    <h2>Our Vision</h2>
                    <p>To be a trusted and leading provider of patient care support services in Mumbai & Thane, ensuring that bedridden and elderly patients receive the right care, treatment, and assistance within the comfort of their homes.</p>
                    <p>We strive to create a support system where families can continue their daily lives worry-free, knowing their loved ones are in safe and capable hands. Through our dedicated services, we aim to bring relief to families and dignity, comfort, and well-being to patients, making home care a seamless and stress-free experience.</p>
                `,
                'mission': `
                    <h2>Our Mission</h2>
                    <p>Our mission is to enhance the quality of life for patients and their families by providing high-quality medical equipment on a rental basis and well-trained caregivers who deliver personalized and dedicated care.</p>
                    <p>We aim to be the preferred choice for home care services in Mumbai & Thane, ensuring dignity, comfort, and reliable support for all our clients. Our goal is to ease the burden on family members while ensuring a safe and comfortable experience for patients.</p>
                `
            };

            // Update content
            document.getElementById('contentArea').innerHTML = content[section];

            // Highlight active link
            document.querySelectorAll('.list-group-item').forEach(link => link.classList.remove('active'));
            document.getElementById(section + '-link').classList.add('active');
        }
        window.onload = function () {
            loadContent('about');
        };

    </script>

    <style>
        @media (max-width: 767px) {
            #contentArea {
                margin-top: 20px;
            }
        }

        .list-group-item.active {
            background-color: #969696  !important;
            color: white;
            font-weight: bold;
            border-color: #0d6efd;
        }

        .list-group-item:hover {
            cursor: pointer;
        }

        #contentArea h2 {
            font-size: 1.75rem;
        }

        #contentArea p {
            font-size: 1rem;
            line-height: 1.6;
        }
    </style>
</asp:Content>
