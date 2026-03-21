<script lang="ts">
	import { resolve } from '$app/paths';
	import BreadCrumbNav from '$lib/components/global/BreadCrumbNav.svelte';
	import { Database, Lock, ShieldCheck, Smartphone, FileKey2, UserCheck } from '@lucide/svelte';
	import { motion } from 'motion-sv';
	import { cubicOut } from 'svelte/easing';
	import { fade, fly, scale } from 'svelte/transition';
	import { onMount } from 'svelte';

	let reveal = $state(false);

	onMount(() => {
		reveal = true;
	});

	const privacyPoints = [
		'We collect only the information needed to provide role-based services for Hustlers and Employers in Botswana.',
		'Profile and contact details may include Botswana-specific formats, including +267 phone numbers and location data relevant to local work opportunities.',
		'Your account, profile records, applications, and media are managed through Firebase services (Authentication, Cloud Firestore, and Storage).',
		'We do not sell personal information. Access is limited to authorized operational use and platform support.'
	];

	const securityPoints = [
		'Secure sign-in and role-aware access controls are used to protect Hustler and Employer experiences.',
		'Data is protected with industry-standard encryption in transit and at rest through Firebase infrastructure.',
		'We monitor platform behavior and enforce permission checks for profile edits, uploads, and job/application workflows.',
		'Users should protect account credentials and report suspicious activity immediately through support channels.'
	];

	const userControlPoints = [
		'You can update profile information and uploaded content from your account settings.',
		'You can request account support for access, corrections, or removal according to platform policy and legal obligations.',
		'Media uploads and profile details are editable to help keep job-seeker and employer records accurate.'
	];
</script>

<div class="min-h-screen bg-white">
	{#if reveal}
		<section
			data-nav-theme="dark"
			in:fade={{ duration: 340 }}
			class="relative overflow-hidden bg-linear-to-br from-[#0F172A] to-[#1E293B]"
		>
			<div class="pointer-events-none absolute inset-0">
				<motion.div
					class="absolute top-10 left-8 h-60 w-60 rounded-full bg-[#00E676]/12 blur-[90px]"
					animate={{ x: [0, 28, 0], y: [0, 22, 0] }}
					transition={{ duration: 16, repeat: Infinity, ease: 'easeInOut' }}
				/>
			</div>

			<div class="relative mx-auto flex min-h-[90vh] max-w-6xl flex-col px-6 pt-28 pb-16">
				<div class="relative z-20 mb-10 w-full">
					<BreadCrumbNav variant="dark" />
				</div>

				<div class="my-auto text-center">
					<div
						in:scale={{ duration: 380, start: 0.94 }}
						class="mb-6 inline-flex items-center gap-2 rounded-full border border-emerald-300/30 bg-emerald-400/10 px-4 py-2 text-sm font-semibold text-emerald-300"
					>
						<ShieldCheck size={16} />
						<span>Trust, privacy, and data protection</span>
					</div>
					<h1
						in:fly={{ y: 24, duration: 520, easing: cubicOut }}
						class="font-space-grotesk mb-5 text-5xl font-bold text-white md:text-6xl"
					>
						Privacy and <span class="text-[#00E676]">Security</span>
					</h1>
					<p class="mx-auto max-w-3xl text-lg text-slate-200 md:text-xl">
						Hustle Link Botswana is built to help local employers and hustlers connect safely while
						protecting personal data and platform integrity.
					</p>
				</div>
			</div>
		</section>

		<section data-nav-theme="light" class="py-20">
			<div class="mx-auto grid max-w-6xl gap-8 px-6 md:grid-cols-2">
				<article
					in:fly={{ x: -24, duration: 460, easing: cubicOut }}
					class="rounded-3xl border border-slate-200 bg-white p-8 shadow-[0_18px_40px_rgba(15,23,42,0.06)]"
				>
					<div class="mb-4 flex items-center gap-3">
						<div class="rounded-xl bg-[#00E676] p-3 text-white"><Database size={22} /></div>
						<h2 class="font-space-grotesk text-2xl font-bold text-[#0F172A]">Privacy</h2>
					</div>
					<ul class="space-y-4 text-gray-700">
						{#each privacyPoints as point, i (`privacy-${i}`)}
							<li class="flex items-start gap-3">
								<UserCheck class="mt-1 shrink-0 text-[#00E676]" size={18} />
								<span>{point}</span>
							</li>
						{/each}
					</ul>
				</article>

				<article
					in:fly={{ x: 24, duration: 460, easing: cubicOut }}
					class="rounded-3xl border border-slate-200 bg-white p-8 shadow-[0_18px_40px_rgba(15,23,42,0.06)]"
				>
					<div class="mb-4 flex items-center gap-3">
						<div class="rounded-xl bg-[#00E676] p-3 text-white"><Lock size={22} /></div>
						<h2 class="font-space-grotesk text-2xl font-bold text-[#0F172A]">Security</h2>
					</div>
					<ul class="space-y-4 text-gray-700">
						{#each securityPoints as point, i (`security-${i}`)}
							<li class="flex items-start gap-3">
								<FileKey2 class="mt-1 shrink-0 text-[#00E676]" size={18} />
								<span>{point}</span>
							</li>
						{/each}
					</ul>
				</article>
			</div>
		</section>

		<section class="bg-slate-50 py-18" data-nav-theme="light">
			<div class="mx-auto max-w-5xl px-6">
				<div
					class="rounded-3xl border border-slate-200 bg-white p-8 md:p-10"
					in:fade={{ duration: 420 }}
				>
					<div class="mb-4 flex items-center gap-3">
						<div class="rounded-xl bg-[#00E676] p-3 text-white"><Smartphone size={22} /></div>
						<h2 class="font-space-grotesk text-2xl font-bold text-[#0F172A]">Your Controls</h2>
					</div>
					<ul class="space-y-4 text-gray-700">
						{#each userControlPoints as point, i (`control-${i}`)}
							<li>{point}</li>
						{/each}
					</ul>
					<p class="mt-8 text-sm text-gray-500">
						If you have privacy or security concerns, contact the HustleLink team through the
						support channels on the contact page.
					</p>
					<a
						href={resolve('/contact')}
						class="font-space-grotesk mt-6 inline-block rounded-full bg-[#00E676] px-6 py-3 font-bold text-[#0F172A] transition-colors hover:bg-emerald-400"
					>
						Contact Support
					</a>
				</div>
			</div>
		</section>
	{/if}
</div>
