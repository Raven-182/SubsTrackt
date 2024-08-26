<h2>Overview</h2>
<p style="font-family: Arial, sans-serif; line-height: 1.6; margin: 20px; background-color: #f4f4f4;">
    The <strong>SubsTrackt App</strong> is a SwiftUI-based application that allows users to manage and track their subscriptions efficiently. With features like monthly and yearly subscription filtering, total cost calculation, and a sleek, modern design, this app helps users stay on top of their recurring expenses.
</p>

<h2>Features</h2>
<ul style="font-family: Arial, sans-serif; line-height: 1.6; margin: 20px;">
    <li><strong>A modern and attractive UI</strong> to display all your subscriptions in one place so you never forget to cancel them on time.</li>
    <li><strong>Subscription Management:</strong> Add, update, and delete subscriptions with ease.</li>
    <li><strong>Monthly and Yearly View:</strong> Filter subscriptions by month and year to view active subscriptions and total costs.</li>
    <li><strong>Dynamic Filtering:</strong> Subscriptions automatically update based on the selected month and year.</li>
    <li><strong>User Authentication:</strong> Secure user authentication using Firebase.</li>
    <li><strong>Dark Mode Support:</strong> A sleek, futuristic theme with gradient backgrounds.</li>
</ul>

<h2>Installation</h2>

<h3>Prerequisites</h3>
<ul style="font-family: Arial, sans-serif; line-height: 1.6; margin: 20px;">
    <li><strong>macOS</strong> with Xcode 12.5 or later</li>
    <li><strong>iOS 14.0</strong> or later</li>
    <li><strong>Swift 5.3</strong> or later</li>
    <li><strong>Firebase</strong> setup (for authentication and database management)</li>
</ul>

<h3>Clone the Repository</h3>
<pre style="background-color: #333; color: #fff; padding: 10px; border-radius: 5px;">
<code>git clone https://github.com/Raven-182/SubsTrackt.git
cd SubsTrackt
</code></pre>

<h3>Setup Firebase</h3>
<ol style="font-family: Arial, sans-serif; line-height: 1.6; margin: 20px;">
    <li>Go to the <a href="https://console.firebase.google.com/" target="_blank">Firebase Console</a>.</li>
    <li>Create a new project.</li>
    <li>Add an iOS app to your project and download the <code style="background-color: #f4f4f4; padding: 2px 4px; border-radius: 4px;">GoogleService-Info.plist</code> file.</li>
    <li>Drag the <code style="background-color: #f4f4f4; padding: 2px 4px; border-radius: 4px;">GoogleService-Info.plist</code> file into your Xcode project.</li>
    <li>Make sure the Firebase dependencies are installed.</li>
</ol>

<h3>Run the App</h3>
<ol style="font-family: Arial, sans-serif; line-height: 1.6; margin: 20px;">
    <li>Select the target device or simulator.</li>
    <li>Click the <strong>Run</strong> button in Xcode.</li>
</ol>

<h2>Usage</h2>
<ol style="font-family: Arial, sans-serif; line-height: 1.6; margin: 20px;">
    <li><strong>Sign Up/In:</strong> Create an account or log in using your existing credentials. Google accounts can be used for quick sign ups.</li>
    <li><strong>Get Notified:</strong> Get notified about when your subscriptions are due to be paid. Set up custom notification frequency.</li>
    <li><strong>Add Subscription:</strong> Add your monthly subscriptions on the Add Subscriptions page.</li>
    <li><strong>View Subscriptions:</strong> Navigate through different months and years using the picker to view your active subscriptions and the total amount due.</li>
    <li><strong>Edit Subscription:</strong> Select a subscription from the list to edit or update its details.</li>
    <li><strong>Delete Subscription:</strong> Remove subscriptions that are no longer active.</li>
</ol>
