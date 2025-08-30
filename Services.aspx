<%@ Page Title="Services" Language="C#" MasterPageFile="~/Site.Master"  AutoEventWireup="true" MaintainScrollPositionOnPostBack="true" CodeBehind="Services.aspx.cs" Inherits="Seva_Bureau.Services"  %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
   <style>
    .service-card {
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
}

.service-img {
    height: 200px;
    object-fit: cover;
}

.card-body {
    flex-grow: 1;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
}

    .modal-img {
        height: 250px;
        object-fit: contain;
    }
     
   
.service-toggle-btn {
    min-height: 50px;
    font-weight: 600;
    transition: all 0.3s ease, box-shadow 0.3s ease;
    white-space: normal; /* allow wrapping */
    word-break: break-word;
    text-align: center;
    padding: 10px;
    font-size: 1rem;
}

input.active-btn {
    background-color:#F1A034 !important;
    color: #fff;
    border-color: #0d6efd;
    box-shadow: 0 6px 16px rgba(0, 0, 0, 0.3), 0 2px 4px rgba(13, 110, 253, 0.6);
}
input.inactive-btn {
    background-color: gray !important;
    color: #000 !important;
    border-color: #ccc !important;
    box-shadow: none !important;
}
#modalDescription {
    text-align: left;
}


</style>

    <main aria-labelledby="title">
        <h2 id="title" class="text-center mt-4"><%: Title %></h2>

       <!-- Service Category Buttons (Responsive) -->
<div class="container mb-4">
    <div class="row justify-content-center g-3">
        <div class="col-12 col-md-4">
            <asp:Button ID="btnCareTaker" runat="server" Text="Care Taker Services"
                CssClass="btn service-toggle-btn active-btn w-100" OnClick="btnCareTaker_Click" />
        </div>
        <div class="col-12 col-md-4">
            <asp:Button ID="btnMedicalEquipment" runat="server" Text="Buy & Rental Medical Equipment"
                CssClass="btn service-toggle-btn active-btn w-100" OnClick="btnMedicalEquipment_Click" />
        </div>
    </div>
</div>




        <!-- Dynamic Content Section -->
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                 <div id="servicesSection">
                <asp:MultiView ID="MultiView1" runat="server">
                    
                    <!-- Care Taker Services View -->
                    <asp:View ID="ViewCareTaker" runat="server">
                        <div class="container">
                            <div class="row">
                                <asp:Repeater ID="rptCareTaker" runat="server">
                                    <ItemTemplate>
                                        <div class="col-md-4 col-lg-3 mb-4 ">
                                            <div class="card service-card shadow-lg border-0">
                                                <img src='<%# ResolveUrl(Eval("ImageUrl").ToString()) %>' class="card-img-top service-img" alt="Service Image">
                                                <div class="card-body text-center">
                                                    <h5 class="card-title"><%# Eval("Name") %></h5>
                                                    <button class="btn btn-info mt-2" onclick="showDetails('<%# Eval("ID") %>')">More Info</button>
                                                </div>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                    </asp:View>

                    <!-- Medical Equipment View -->
                    <asp:View ID="ViewMedicalEquipment" runat="server">
                        <div class="container">
                            <h4 class="text-center">Available Medical Equipment</h4>
                            <div class="row">
                                <asp:Repeater ID="rptMedicalEquipment" runat="server">
                                    <ItemTemplate>
                                        <div class="col-md-4 col-lg-4 mb-4">
                                            <div class="card service-card shadow-sm border">
                                                <img src='<%# ResolveUrl(Eval("ImageUrl").ToString()) %>' class="card-img-top service-img" alt="Equipment Image">
                                                <div class="card-body text-center">
                                                    <h5 class="card-title"><%# Eval("Name") %></h5>
                                                </div>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                    </asp:View>

                </asp:MultiView>
            </div>
                     </ContentTemplate>
        </asp:UpdatePanel>

        <!-- Modal for Service Details -->

  <!-- Modal for Service Details -->
<div class="modal fade" id="serviceModal" tabindex="-1" aria-labelledby="serviceModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <!-- Header -->
            <div class="modal-header bg-secondary text-white">
                <h5 class="modal-title w-100 text-center" id="serviceModalLabel">Service Title</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <!-- Body -->
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">
                        <!-- Image -->
                        <div class="col-md-5 text-center">
                            <img id="modalImage1" src="" class="img-fluid modal-img" alt="Service Image">
                        </div>
                        <!-- Description -->
                        <div class="col-md-7 d-flex flex-column justify-content-center">
                            <p id="modalDescription" class="description-text text-start"></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


    </main>

  <script>
      let scrollPosition = 0;

      function showDetails(id) {
          scrollPosition = window.scrollY || document.documentElement.scrollTop;

          // Set modal content (your existing logic)
          var services = {
              "1": { name: "Home Caretakers", image1: "Content/images/serv1.png", image2: "Content/images/elderly-care2.jpg", description: "Caregivers providing daily support for bedridden and elderly patients, assisting with hygiene, mobility, feeding, and companionship." },
              "2": { name: "Day & Night Caregivers", image1: "Content/images/serv2.png", image2: "Content/images/surgery-care2.jpg", description: "Flexible care available for specific shifts, ensuring patients receive assistance with medication, mobility, hygiene, and safety during the day or night." },
              "3": { name: "Paralysis & Stroke Patient Care", image1: "Content/images/serv3.png", image2: "Content/images/disabled-care2.jpg", description: "Specialized care focused on rehabilitation, physiotherapy support, hygiene, mobility assistance, and overall well-being." },
              "4": { name: "Post-Surgical & Recovery Care", image1: "Content/images/serv4.png", image2: "Content/images/wheelchair2.jpg", description: "Professional care for patients recovering from surgery, including medication reminders, wound care, mobility assistance, and hygiene maintenance." },
              "5": { name: "Palliative Care", image1: "Content/images/serv5.png", image2: "Content/images/elderly-care2.jpg", description: "Compassionate support for terminally ill patients, focusing on pain relief, emotional well-being, and ensuring comfort and respect in their final stages." },
              "6": { name: "Wound Dressing & Post-Operative Care", image1: "Content/images/serv6.png", image2: "Content/images/surgery-care2.jpg", description: "Skilled caregivers providing regular dressing changes, monitoring infections, assisting in recovery, and ensuring proper healing." },
              "7": { name: "Basic House Help for Patients", image1: "Content/images/serv7.png", image2: "Content/images/disabled-care2.jpg", description: "Assistance with household tasks like meal preparation, light cleaning, and ensuring a hygienic and comfortable environment for the patient." }
          };

          const service = services[id];
          if (service) {
              document.getElementById("serviceModalLabel").innerText = service.name;
              document.getElementById("modalDescription").innerText = service.description;
              document.getElementById("modalImage1").src = service.image1;
          }

          // Show modal
          var modal = new bootstrap.Modal(document.getElementById('serviceModal'));
          modal.show();
      }

      document.getElementById('serviceModal').addEventListener('hidden.bs.modal', function () {
          // Use a short delay to allow reflow before restoring scroll
          setTimeout(() => {
              window.scrollTo({ top: scrollPosition, behavior: 'instant' });
          }, 50);
      });

  </script>
										


</asp:Content>
