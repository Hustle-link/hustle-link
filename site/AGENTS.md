## Project Configuration

- **Language**: TypeScript
- **Package Manager**: npm
- **Add-ons**: prettier, eslint, vitest, playwright, tailwindcss, sveltekit-adapter, mcp, devtools-json

---

You are able to use the Svelte MCP server, where you have access to comprehensive Svelte 5 and SvelteKit documentation. Here's how to use the available tools effectively:

## Available MCP Tools

### 1. list-sections

Use this FIRST to discover all available documentation sections. Returns a structured list with titles, use_cases, and paths.
When asked about Svelte or SvelteKit topics, ALWAYS use this tool at the start of the chat to find relevant sections.

### 2. get-documentation

Retrieves full documentation content for specific sections. Accepts single or multiple sections.
After calling the list-sections tool, you MUST analyze the returned documentation sections (especially the use_cases field) and then use the get-documentation tool to fetch ALL documentation sections that are relevant for the user's task.

### 3. svelte-autofixer

Analyzes Svelte code and returns issues and suggestions.
You MUST use this tool whenever writing Svelte code before sending it to the user. Keep calling it until no issues or suggestions are returned.

### 4. playground-link

Generates a Svelte Playground link with the provided code.
After completing the code, ask the user if they want a playground link. Only call this tool after user confirmation and NEVER if code was written to files in their project.

### 5. awareness

This a project for a product launch of a new HustleLink app, for people who are on job hunting and employment. The app will be a platform for job seekers to connect with potential employers, share their resumes, and find job opportunities. The app will also have features such as job alerts, interview preparation resources, and networking opportunities. The goal of the app is to help job seekers find their dream jobs and connect with the right employers.

### 6. take-note-on

Always comment your code with clear explanations of what each part does. This will help the user understand the code and make it easier for them to modify it in the future. Additionally, provide comments on any complex logic or important decisions made in the code to ensure clarity and maintainability.

### 7. practices-to-note

When writing code for the HustleLink app, follow these best practices:

- **Modularity**: Break down the code into smaller, reusable components to improve maintainability and readability.
- **Consistency**: Use consistent naming conventions and coding styles throughout the project to enhance readability and collaboration.
- **Documentation**: Comment your code thoroughly to explain the purpose and functionality of each part, making it easier for others to understand and contribute to the project.
- **Other best practices**: Follow industry standards for security, performance, and accessibility to ensure the app is robust and user-friendly. This includes validating user input, optimizing performance, and ensuring the app is accessible to all users. Use motion-sv, svelte-animate, and svelte-transitions to enhance the user experience with smooth animations and transitions.
- **SEO Optimization**: Implement SEO best practices to improve the app's visibility in search engines. This includes using semantic HTML, optimizing meta tags, and ensuring fast load times.
- **Forms, Validation, User Feedback, Typography, and Accessibility**: Ensure that all forms are user-friendly and include proper validation to enhance the user experience. Provide clear feedback for user actions, use readable typography, and ensure the app is accessible to users with disabilities by following accessibility guidelines. Use tailwind typography utilities to enhance the visual appeal and readability of the app. Tailwind form utilities can be used to create consistent and visually appealing forms, while Tailwind's accessibility utilities can help ensure the app is usable by all users.

- **Forms, Validation, User Feedback, Typography, and Accessibility**: Ensure that all forms are user-friendly and include proper validation to enhance the user experience. Provide clear feedback for user actions, use readable typography, and ensure the app is accessible to users with disabilities by following accessibility guidelines. Use tailwind typography utilities to enhance the visual appeal and readability of the app. Tailwind form utilities can be used to create consistent and visually appealing forms, while Tailwind's accessibility utilities can help ensure the app is usable by all users.
