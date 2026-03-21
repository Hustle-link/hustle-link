<script lang="ts">
	import { resolve } from '$app/paths';
	import HelpFaqSection from '$lib/components/pages/help/HelpFaqSection.svelte';
	import HelpHeroSection from '$lib/components/pages/help/HelpHeroSection.svelte';
	import HelpQuickLinksSection from '$lib/components/pages/help/HelpQuickLinksSection.svelte';
	import HelpSupportCta from '$lib/components/pages/help/HelpSupportCta.svelte';
	import { BookOpen, HelpCircle, MessageCircle, Users } from '@lucide/svelte';
	import { onMount } from 'svelte';
	import type { FaqCategory, QuickLink } from '$lib/components/pages/help/help.types';

	// FAQ content is grouped by task so search results stay readable instead of becoming one long list.
	const faqs: FaqCategory[] = [
		{
			category: 'Getting Started',
			icon: BookOpen,
			questions: [
				{
					q: 'How do I create an account?',
					a: 'Download the HustleLink app from your app store, tap "Sign Up", and follow the prompts to create your profile. You will need a valid email address and phone number.'
				},
				{
					q: 'How do I upload my certifications?',
					a: 'Go to your profile, tap "Certifications", then "Add Certification". You can upload images or PDFs of your BQA certificates directly from your device.'
				},
				{
					q: 'Is HustleLink free to use?',
					a: 'Yes. HustleLink is completely free for job seekers. We only charge employers who post job listings.'
				}
			]
		},
		{
			category: 'Job Applications',
			icon: Users,
			questions: [
				{
					q: 'How does the AI matching work?',
					a: 'Our AI analyzes your skills, certifications, experience, and preferences to match you with relevant job opportunities. The match percentage shows how well you fit each role.'
				},
				{
					q: 'How long does it take to hear back from employers?',
					a: 'Most employers review applications within 48-72 hours. You will receive a notification when your application status changes.'
				},
				{
					q: 'Can I apply to multiple jobs at once?',
					a: 'Yes. You can apply to as many jobs as you like. We recommend tailoring your application to each position for the best results.'
				}
			]
		},
		{
			category: 'Account & Security',
			icon: HelpCircle,
			questions: [
				{
					q: 'How do I reset my password?',
					a: 'Tap "Sign In", then "Forgot Password". Enter your email address and we will send you a reset link.'
				},
				{
					q: 'Is my personal information secure?',
					a: 'Absolutely. We use bank-level encryption to protect your data and never share your information without your permission.'
				},
				{
					q: 'How do I delete my account?',
					a: 'Go to Settings > Account > Delete Account. Note that this action is permanent and cannot be undone.'
				}
			]
		}
	];

	const quickLinks: QuickLink[] = [
		{
			id: 'guide',
			title: 'User Guide',
			description: 'Step-by-step tutorials and onboarding guidance.',
			icon: BookOpen,
			href: resolve('/download')
		},
		{
			id: 'support',
			title: 'Contact Support',
			description: 'Reach the HustleLink team for direct assistance.',
			icon: MessageCircle,
			href: resolve('/contact')
		},
		{
			id: 'community',
			title: 'Community Forum',
			description: 'Connect with other users and share practical tips.',
			icon: Users,
			href: '#faqs'
		}
	];

	let reveal = $state(false);
	let searchQuery = $state('');

	// Reveal the page with Svelte transitions once the component is mounted.
	onMount(() => {
		reveal = true;
	});

	const filteredFaqs = $derived.by(() => {
		const query = searchQuery.trim().toLowerCase();

		if (!query) {
			return faqs;
		}

		return faqs
			.map((category) => {
				const questions = category.questions.filter((item) => {
					const haystack = `${category.category} ${item.q} ${item.a}`.toLowerCase();
					return haystack.includes(query);
				});

				return {
					...category,
					questions
				};
			})
			.filter((category) => category.questions.length > 0);
	});

	const resultCount = $derived(
		filteredFaqs.reduce((count, category) => count + category.questions.length, 0)
	);
</script>

<div class="min-h-screen bg-white">
	{#if reveal}
		<HelpHeroSection bind:searchQuery {resultCount} />

		<HelpQuickLinksSection {quickLinks} />

		<HelpFaqSection {filteredFaqs} />

		<HelpSupportCta />
	{/if}
</div>
