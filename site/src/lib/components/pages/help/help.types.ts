import type { Component } from 'svelte';

export type HelpIcon = Component<{ size?: number; class?: string }>;

export type FaqItem = {
	q: string;
	a: string;
};

export type FaqCategory = {
	category: string;
	icon: HelpIcon;
	questions: FaqItem[];
};

export type QuickLink = {
	id: string;
	title: string;
	description: string;
	icon: HelpIcon;
	href: string;
};
