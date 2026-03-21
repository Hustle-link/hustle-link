<script lang="ts">
	import { resolve } from '$app/paths';
	import BreadCrumbNav from '$lib/components/global/BreadCrumbNav.svelte';
	import ContactFormCard from '$lib/components/pages/contact/ContactFormCard.svelte';
	import ContactInfoPanel from '$lib/components/pages/contact/ContactInfoPanel.svelte';
	import { Mail, MapPin, MessageCircle, Phone, Sparkles } from '@lucide/svelte';
	import { motion } from 'motion-sv';
	import { cubicOut, quintOut } from 'svelte/easing';
	import { onMount } from 'svelte';
	import { fade, fly, scale, slide } from 'svelte/transition';
	import type { ContactMethod, SocialLink } from '$lib/components/pages/contact/contact.types';

	const contactMethods: ContactMethod[] = [
		{
			id: 'email',
			icon: Mail,
			title: 'Email',
			description: ['support@hustlelink.bw'],
			href: 'mailto:support@hustlelink.bw'
		},
		{
			id: 'phone',
			icon: Phone,
			title: 'Phone',
			description: ['+267 71 234 567'],
			href: 'tel:+26771234567'
		},
		{
			id: 'office',
			icon: MapPin,
			title: 'Office',
			description: ['Plot 50371, Fairgrounds', 'Gaborone, Botswana']
		},
		{
			id: 'chat',
			icon: MessageCircle,
			title: 'Live Chat',
			description: ['Available Mon-Fri', '8:00 AM - 6:00 PM CAT']
		}
	];

	const socialLinks: SocialLink[] = [
		{ id: 'facebook', label: 'Facebook', href: '#', accent: 'from-sky-400 to-blue-500' },
		{ id: 'twitter', label: 'Twitter', href: '#', accent: 'from-slate-800 to-slate-600' },
		{ id: 'linkedin', label: 'LinkedIn', href: '#', accent: 'from-blue-500 to-cyan-500' },
		{ id: 'instagram', label: 'Instagram', href: '#', accent: 'from-pink-500 to-orange-400' }
	] as const;

	let reveal = $state(false);
	let isSubmitting = $state(false);
	let submitted = $state(false);
	let formData = $state({
		name: '',
		email: '',
		subject: '',
		message: ''
	});

	// Trigger section-level built-in transitions after mount.
	onMount(() => {
		reveal = true;
	});

	async function handleSubmit(event: SubmitEvent) {
		event.preventDefault();
		isSubmitting = true;
		submitted = false;

		// Simulate a lightweight submit flow until a backend endpoint is wired in.
		await new Promise((resolvePromise) => setTimeout(resolvePromise, 900));

		isSubmitting = false;
		submitted = true;
		formData = {
			name: '',
			email: '',
			subject: '',
			message: ''
		};
	}
</script>

<div class="min-h-screen bg-white">
	{#if reveal}
		<section
			data-nav-theme="dark"
			in:fade={{ duration: 350 }}
			class="relative overflow-hidden bg-linear-to-br from-[#0F172A] via-[#111D33] to-[#1E293B]"
		>
			<div class="pointer-events-none absolute inset-0 overflow-hidden">
				<motion.div
					class="absolute top-16 left-8 h-64 w-64 rounded-full bg-[#00E676]/12 blur-[90px]"
					animate={{ x: [0, 46, 0], y: [0, 28, 0] }}
					transition={{ duration: 14, repeat: Infinity, ease: 'easeInOut' }}
				/>
				<motion.div
					class="absolute right-0 bottom-4 h-80 w-80 rounded-full bg-emerald-300/10 blur-[110px]"
					animate={{ x: [0, -34, 0], y: [0, -24, 0] }}
					transition={{ duration: 18, repeat: Infinity, ease: 'easeInOut' }}
				/>
				<div
					class="absolute inset-0 opacity-30"
					style="background-image: linear-gradient(rgba(255,255,255,0.08) 1px, transparent 1px), linear-gradient(90deg, rgba(255,255,255,0.08) 1px, transparent 1px); background-size: 4rem 4rem; mask-image: radial-gradient(circle at center, black 28%, transparent 90%);"
				></div>
			</div>

			<div class="relative mx-auto flex min-h-[90vh] max-w-6xl flex-col px-6 pt-28 pb-16">
				<div class="relative z-20 mb-10 w-full">
					<BreadCrumbNav variant="dark" />
				</div>

				<div class="my-auto text-center">
					<div
						in:scale={{ duration: 480, start: 0.94, easing: quintOut }}
						class="mb-8 inline-flex items-center gap-2 rounded-full border border-emerald-300/30 bg-emerald-400/10 px-4 py-2 text-sm font-semibold tracking-wide text-emerald-300"
					>
						<Sparkles size={16} />
						<span>Support, partnerships, and launch questions</span>
					</div>

					<h1
						in:fly={{ y: 28, duration: 560, easing: cubicOut }}
						class="font-space-grotesk mb-6 text-5xl font-bold text-white md:text-7xl"
					>
						Get in <span class="text-[#00E676]">Touch</span>
					</h1>

					<p
						in:fly={{ y: 20, duration: 620, delay: 120, easing: cubicOut }}
						class="mx-auto max-w-3xl text-lg leading-relaxed text-slate-200 md:text-xl"
					>
						Have questions about HustleLink, hiring, or the product launch? Send a message and the
						team will get back to you as quickly as possible.
					</p>

					<div
						in:slide={{ duration: 420, axis: 'y' }}
						class="mt-10 flex flex-wrap items-center justify-center gap-4"
					>
						<a
							href={resolve('/')}
							class="rounded-full border border-white/15 bg-white/6 px-5 py-3 text-sm font-semibold text-white transition-colors hover:bg-white/10"
						>
							Back to Home
						</a>
						<div
							class="inline-flex items-center gap-3 rounded-full bg-white/8 px-5 py-3 text-sm text-slate-200"
						>
							<motion.div
								class="h-2 w-2 rounded-full bg-[#00E676]"
								animate={{ scale: [1, 1.35, 1], opacity: [1, 0.6, 1] }}
								transition={{ duration: 2.2, repeat: Infinity }}
							/>
							<span>Average response time: 2-4 hours</span>
						</div>
					</div>
				</div>
			</div>
		</section>

		<section class="bg-linear-to-b from-white via-white to-slate-50 py-24">
			<div class="mx-auto max-w-7xl px-6">
				<div class="grid gap-12 lg:grid-cols-[0.95fr_1.45fr]">
					<ContactInfoPanel {contactMethods} {socialLinks} />

					<ContactFormCard
						bind:name={formData.name}
						bind:email={formData.email}
						bind:subject={formData.subject}
						bind:message={formData.message}
						{submitted}
						{isSubmitting}
						{handleSubmit}
					/>
				</div>
			</div>
		</section>

		<section class="bg-slate-50 py-16" data-nav-theme="light">
			<div class="mx-auto max-w-7xl px-6">
				<div in:fade={{ duration: 420 }} class="text-center">
					<div
						class="mb-4 inline-flex items-center gap-3 rounded-full bg-[#00E676]/10 px-6 py-3 text-[#00E676]"
					>
						<motion.div
							class="h-2 w-2 rounded-full bg-[#00E676]"
							animate={{ scale: [1, 1.4, 1], opacity: [1, 0.55, 1] }}
							transition={{ duration: 2, repeat: Infinity }}
						/>
						<span class="text-sm font-semibold">Avg. Response Time: 2-4 hours</span>
					</div>
					<p class="mx-auto max-w-3xl text-gray-600">
						Our support team typically replies within 2-4 hours during business hours, Monday to
						Friday, 8:00 AM to 6:00 PM CAT.
					</p>
				</div>
			</div>
		</section>
	{/if}
</div>
