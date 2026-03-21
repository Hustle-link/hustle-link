import type { Component } from 'svelte';

export type ContactMethod = {
	id: string;
	icon: Component<{ size?: number; class?: string }>;
	title: string;
	description: string[];
	href?: string;
};

export type SocialLink = {
	id: string;
	label: string;
	href: string;
	accent: string;
};
