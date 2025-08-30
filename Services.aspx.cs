using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;

namespace Seva_Bureau
{
    public partial class Services : System.Web.UI.Page
    {
        protected void Page_PreInit(object sender, EventArgs e)
        {
            if (Request.Browser.IsMobileDevice)
            {
                this.MasterPageFile = "~/Site.mobile.master";
            }
            else
            {
                this.MasterPageFile = "~/Site.master";
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
           
            if (!IsPostBack)
            {
                LoadCareTakerServices();
                LoadMedicalEquipment();

                MultiView1.SetActiveView(ViewCareTaker); // Default View

                // Ensure Care Taker button is highlighted by default

                btnCareTaker.CssClass = "btn service-toggle-btn w-100 active-btn";
                btnMedicalEquipment.CssClass = "btn service-toggle-btn w-100 inactive-btn";
            }
        }

        private void LoadCareTakerServices()
        {
            var services = new List<dynamic>
        {
            new { ID = "1", Name = "Home Caretakers", ImageUrl = "~/Content/images/serv1.png" },
            new { ID = "2", Name = "Day & Night Caregivers", ImageUrl = "~/Content/images/serv2.png" },
            new { ID = "3", Name = "Paralysis & stroke patient care", ImageUrl = "~/Content/images/serv3.png" },
            new { ID = "4", Name = "Post surgical & recovery care", ImageUrl = "~/Content/images/serv4.png" },
            new { ID = "5", Name = "Palliative Care", ImageUrl = "~/Content/images/serv5.png" },
            new { ID = "6", Name = "Wound dressing & Post-operative care", ImageUrl = "~/Content/images/serv6.png" },
            new { ID = "7", Name = "Basic House help for patients", ImageUrl = "~/Content/images/serv7.png" }
        };

            rptCareTaker.DataSource = services;
            rptCareTaker.DataBind();
        }

        private void LoadMedicalEquipment()
        {
            var equipment = new List<dynamic>
        {
            new { ID = "8", Name = "Wheelchair (Manual)", ImageUrl = "~/Content/images/Equip1.png" },
            new { ID = "9", Name = "Walker", ImageUrl = "~/Content/images/Equipm2.png" },
            new { ID = "10", Name = "Hospital Beds", ImageUrl = "~/Content/images/Equip3.png" },
            new { ID = "11", Name = "Air Bed, Water Bed.", ImageUrl = "~/Content/images/Equip4.png" },
            new { ID = "12", Name = "Oxygen Concentrator", ImageUrl = "~/Content/images/Equip5.png" },
            new { ID = "13", Name = "Nebulizer", ImageUrl = "~/Content/images/Equip6.png" }
        };

            rptMedicalEquipment.DataSource = equipment;
            rptMedicalEquipment.DataBind();
        }

        protected void btnCareTaker_Click(object sender, EventArgs e)
        {
            MultiView1.SetActiveView(ViewCareTaker);
            MultiView1.ActiveViewIndex = 0;
            btnCareTaker.CssClass = "btn service-toggle-btn w-100 active-btn";
            btnMedicalEquipment.CssClass = "btn service-toggle-btn w-100 inactive-btn";
        }

        protected void btnMedicalEquipment_Click(object sender, EventArgs e)
        {
            MultiView1.SetActiveView(ViewMedicalEquipment);
            MultiView1.ActiveViewIndex = 1;
            btnMedicalEquipment.CssClass = "btn service-toggle-btn w-100 active-btn";
            btnCareTaker.CssClass = "btn service-toggle-btn w-100 inactive-btn";
        }
    }
}