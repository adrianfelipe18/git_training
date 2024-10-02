document.addEventListener('DOMContentLoaded', (event) => {
    const contentDiv = document.getElementById('content');

    // Function to load content
    function loadContent(page) {
        fetch(`${page}.html`)
            .then(response => response.text())
            .then(data => {
                contentDiv.innerHTML = data;
                // Update the page title
                document.title = `My Website - ${page.replace('_', ' ')}`;

            })
            .catch(error => {
                console.error('Error loading content:', error);
                contentDiv.innerHTML = '<p>Error loading content. Please try again.</p>';
            });
    }

    // Check if we're on the root route and redirect to '/aboutus' if so
	if (window.location.pathname === '/' || window.location.pathname === '') {
        window.location.pathname = 'Home';
    } else {
        // Load content based on URL
        loadContent(window.location.pathname.replace('/', ''));
    }
});

