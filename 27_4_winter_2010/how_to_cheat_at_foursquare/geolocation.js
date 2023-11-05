	if (document.getElementById("fsfx-toolbar-custom-checkbox").checked) {
		json.location.latitude = document.getElementById("fsfx-toolbar-custom-lat").value;
		json.location.longitude = document.getElementById("fsfx-toolbar-custom-long").value;
		json.location.address.street_number = "Custom";
		json.location.address.street = "Location";
		json.location.address.city = "Lat/Long";
	}

