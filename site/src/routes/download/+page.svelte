<script lang="ts">
	import { motion } from 'motion-sv';
	import { Download, Smartphone, Star, CheckCircle2, Zap, ArrowRight } from '@lucide/svelte';
	import { resolve } from '$app/paths';
	import BreadCrumbNav from '$lib/components/global/BreadCrumbNav.svelte';

	interface AppStoreButton {
		icon: string;
		title: string;
		platform: string;
		ctaText: string;
		gradient: string;
		href: string;
	}

	interface Feature {
		icon: typeof Smartphone;
		title: string;
		description: string;
	}

	const appStores: AppStoreButton[] = [
		{
			icon: 'apple',
			title: 'App Store',
			platform: 'Download for iOS',
			ctaText: 'Get on iPhone',
			gradient: 'from-blue-400 to-blue-600',
			href: '#'
		},
		{
			icon: 'google',
			title: 'Google Play',
			platform: 'Download for Android',
			ctaText: 'Get on Android',
			gradient: 'from-green-400 to-blue-500',
			href: '#'
		},
		{
			icon: 'huawei',
			title: 'AppGallery',
			platform: 'Download for Huawei',
			ctaText: 'Get on Huawei',
			gradient: 'from-red-500 to-purple-600',
			href: '#'
		}
	];

	const features: Feature[] = [
		{
			icon: Smartphone,
			title: 'Apply on the Go',
			description: 'Browse and apply to jobs from anywhere in Botswana'
		},
		{
			icon: Star,
			title: 'Instant Notifications',
			description: 'Get alerts when new matches appear for your skills'
		},
		{
			icon: CheckCircle2,
			title: 'Track Applications',
			description: 'Monitor your job applications in real-time'
		},
		{
			icon: Zap,
			title: '24/7 Access',
			description: 'Never miss an opportunity with round-the-clock availability'
		}
	];

	const stats = [
		{ value: '50K+', label: 'Active Users' },
		{ value: '500+', label: 'Live Jobs' },
		{ value: '4.8★', label: 'App Rating' }
	];

	const breadcrumbs = [{ label: 'Home', href: '/' }, { label: 'Download' }];
</script>

<main class="min-h-screen bg-linear-to-br from-[#0F172A] via-[#1E293B] to-[#0F172A]">
	<section data-nav-theme="dark" class="mx-auto max-w-6xl px-6 pt-28 pb-16">
		<motion.section
			initial={{ opacity: 0, y: 30 }}
			animate={{ opacity: 1, y: 0 }}
			transition={{ duration: 0.6 }}
			class="flex min-h-[90vh] flex-col text-center"
		>
			<div class="mb-10 text-left">
				<BreadCrumbNav items={breadcrumbs} variant="dark" />
			</div>

			<div class="my-auto">
				<h1 class="font-space-grotesk mb-6 text-6xl font-bold text-white md:text-7xl">
					Get <span class="text-[#00E676]">HustleLink</span> on Your Device
				</h1>
				<p class="mx-auto max-w-2xl text-xl leading-relaxed text-gray-300">
					Access thousands of Botswana job opportunities right from your mobile device. Available on
					all major platforms.
				</p>
			</div>
		</motion.section>
	</section>

	<!-- Main Content -->
	<div class="mx-auto max-w-5xl px-6 pb-20" data-nav-theme="dark">
		<!-- App Store Buttons -->
		<motion.section
			initial={{ opacity: 0, y: 30 }}
			animate={{ opacity: 1, y: 0 }}
			transition={{ duration: 0.6, delay: 0.2 }}
			class="mb-20 grid gap-6 md:grid-cols-3"
		>
			{#each appStores as store (store.title)}
				<motion.div
					whileHover={{ scale: 1.05, y: -5 }}
					class="group relative rounded-2xl border border-white/20 bg-white/10 p-8 backdrop-blur-md transition-all duration-300 hover:border-[#00E676]"
				>
					<button
						type="button"
						class="block h-full w-full text-left"
						aria-label={`Download HustleLink from ${store.title}`}
					>
						<div class="text-center">
							<div
								class="mx-auto mb-4 h-20 w-20 bg-linear-to-br {store.gradient} flex items-center justify-center rounded-2xl"
							>
								{#if store.icon === 'apple'}
									<svg
										class="h-12 w-12 text-white"
										viewBox="0 0 24 24"
										fill="currentColor"
										aria-hidden="true"
									>
										<path
											d="M17.05 20.28c-.98.95-2.05.8-3.08.35-1.09-.46-2.09-.48-3.24 0-1.44.62-2.2.44-3.06-.35C2.79 15.25 3.51 7.59 9.05 7.31c1.35.07 2.29.74 3.08.8 1.18-.24 2.31-.93 3.57-.84 1.51.12 2.65.72 3.4 1.8-3.12 1.87-2.38 5.98.48 7.13-.57 1.5-1.31 2.99-2.54 4.09l.01-.01zM12.03 7.25c-.15-2.23 1.66-4.07 3.74-4.25.29 2.58-2.34 4.5-3.74 4.25z"
										/>
									</svg>
								{:else if store.icon === 'google'}
									<svg
										class="h-12 w-12 text-white"
										viewBox="0 0 24 24"
										fill="currentColor"
										aria-hidden="true"
									>
										<path
											d="M3,20.5V3.5C3,2.91 3.34,2.39 3.84,2.15L13.69,12L3.84,21.85C3.34,21.6 3,21.09 3,20.5M16.81,15.12L6.05,21.34L14.54,12.85L16.81,15.12M20.16,10.81C20.5,11.08 20.75,11.5 20.75,12C20.75,12.5 20.53,12.9 20.18,13.18L17.89,14.5L15.39,12L17.89,9.5L20.16,10.81M6.05,2.66L16.81,8.88L14.54,11.15L6.05,2.66Z"
										/>
									</svg>
								{:else if store.icon === 'huawei'}
									<svg
										class="h-12 w-12 text-white"
										viewBox="0 0 24 24"
										fill="currentColor"
										aria-hidden="true"
									>
										<path
											d="M12,2A10,10 0 0,1 22,12A10,10 0 0,1 12,22A10,10 0 0,1 2,12A10,10 0 0,1 12,2M12,4A8,8 0 0,0 4,12A8,8 0 0,0 12,20A8,8 0 0,0 20,12A8,8 0 0,0 12,4M12,6A6,6 0 0,1 18,12A6,6 0 0,1 12,18A6,6 0 0,1 6,12A6,6 0 0,1 12,6M12,8A4,4 0 0,0 8,12A4,4 0 0,0 12,16A4,4 0 0,0 16,12A4,4 0 0,0 12,8Z"
										/>
									</svg>
								{/if}
							</div>
							<h3 class="font-space-grotesk mb-2 text-2xl font-bold text-white">
								{store.title}
							</h3>
							<p class="mb-4 text-gray-400">{store.platform}</p>
							<div class="flex items-center justify-center gap-2 text-[#00E676]">
								<Download size={20} />
								<span class="font-medium">{store.ctaText}</span>
							</div>
						</div>
					</button>
				</motion.div>
			{/each}
		</motion.section>

		<!-- Features Grid -->
		<motion.section
			initial={{ opacity: 0, y: 30 }}
			animate={{ opacity: 1, y: 0 }}
			transition={{ duration: 0.6, delay: 0.4 }}
			class="mb-16"
		>
			<h2 class="font-space-grotesk mb-12 text-center text-4xl font-bold text-white">
				Why Download <span class="text-[#00E676]">HustleLink?</span>
			</h2>
			<div class="grid gap-6 md:grid-cols-2">
				{#each features as feature, i (feature.title)}
					<motion.div
						initial={{ opacity: 0, x: -20 }}
						animate={{ opacity: 1, x: 0 }}
						transition={{
							duration: 0.5,
							delay: i * 0.1
						}}
						class="flex items-start gap-4 rounded-2xl border border-white/10 bg-white/5 p-6 backdrop-blur-sm"
					>
						<div
							class="flex h-12 w-12 shrink-0 items-center justify-center rounded-xl bg-[#00E676]"
						>
							<svelte:component this={feature.icon} class="text-[#0F172A]" size={24} />
						</div>
						<div>
							<h3 class="font-space-grotesk mb-2 text-xl font-bold text-white">
								{feature.title}
							</h3>
							<p class="text-gray-400">{feature.description}</p>
						</div>
					</motion.div>
				{/each}
			</div>
		</motion.section>

		<!-- Stats Section -->
		<motion.section
			initial={{ opacity: 0, y: 30 }}
			animate={{ opacity: 1, y: 0 }}
			transition={{ duration: 0.6, delay: 0.8 }}
			class="rounded-3xl border border-[#00E676]/30 bg-linear-to-r from-[#00E676]/20 to-emerald-400/20 p-12 backdrop-blur-md"
		>
			<div class="grid gap-8 text-center md:grid-cols-3">
				{#each stats as stat (stat.value)}
					<div>
						<div class="font-space-grotesk mb-2 text-5xl font-bold text-[#00E676]">
							{stat.value}
						</div>
						<div class="text-gray-300">{stat.label}</div>
					</div>
				{/each}
			</div>
		</motion.section>

		<!-- CTA -->
		<motion.section
			initial={{ opacity: 0, y: 30 }}
			animate={{ opacity: 1, y: 0 }}
			transition={{ duration: 0.6, delay: 1 }}
			class="mt-16 text-center"
		>
			<!-- eslint-disable-next-line -->
			<a
				href={resolve(...(['/'] as unknown as Parameters<typeof resolve>))}
				class="inline-flex items-center gap-2 rounded-lg px-4 py-2 text-[#00E676] transition-colors hover:bg-[#00E676]/10 hover:text-emerald-300"
			>
				<ArrowRight size={20} />
				<span class="font-medium">Browse Jobs on Web</span>
			</a>
		</motion.section>
	</div>
</main>

<style>
	:global(::selection) {
		background-color: #00e676;
		color: #0f172a;
	}
</style>
