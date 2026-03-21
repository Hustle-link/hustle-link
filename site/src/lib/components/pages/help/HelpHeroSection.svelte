<script lang="ts">
	import { resolve } from '$app/paths';
	import BreadCrumbNav from '$lib/components/global/BreadCrumbNav.svelte';
	import { Search, Sparkles } from '@lucide/svelte';
	import { motion } from 'motion-sv';
	import { cubicOut, quintOut } from 'svelte/easing';
	import { fade, fly, scale, slide } from 'svelte/transition';

	interface Props {
		searchQuery?: string;
		resultCount: number;
	}

	let { searchQuery = $bindable(''), resultCount }: Props = $props();
</script>

<section
	data-nav-theme="dark"
	in:fade={{ duration: 350 }}
	class="relative overflow-hidden bg-linear-to-br from-[#0F172A] via-[#111D33] to-[#1E293B]"
>
	<div class="pointer-events-none absolute inset-0 overflow-hidden">
		<motion.div
			class="absolute top-18 left-8 h-64 w-64 rounded-full bg-[#00E676]/12 blur-[90px]"
			animate={{ x: [0, 42, 0], y: [0, 26, 0] }}
			transition={{ duration: 14, repeat: Infinity, ease: 'easeInOut' }}
		/>
		<motion.div
			class="absolute right-0 bottom-0 h-88 w-88 rounded-full bg-emerald-300/10 blur-[120px]"
			animate={{ x: [0, -36, 0], y: [0, -20, 0] }}
			transition={{ duration: 18, repeat: Infinity, ease: 'easeInOut' }}
		/>
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
				<span>Support articles, quick answers, and account guidance</span>
			</div>

			<h1
				in:fly={{ y: 28, duration: 560, easing: cubicOut }}
				class="font-space-grotesk mb-6 text-5xl font-bold text-white md:text-7xl"
			>
				How Can We <span class="text-[#00E676]">Help You?</span>
			</h1>

			<p
				in:fly={{ y: 20, duration: 620, delay: 120, easing: cubicOut }}
				class="mx-auto mb-12 max-w-3xl text-lg leading-relaxed text-slate-200 md:text-xl"
			>
				Search the knowledge base or browse the most common questions about getting started,
				applications, and account security.
			</p>

			<!-- Search input is bindable so filtering remains managed by the route-level state. -->
			<div in:slide={{ duration: 420, axis: 'y' }} class="mx-auto max-w-2xl">
				<label class="relative block text-left">
					<span class="sr-only">Search help articles</span>
					<Search
						class="pointer-events-none absolute top-1/2 left-6 -translate-y-1/2 text-slate-400"
						size={24}
					/>
					<input
						type="text"
						bind:value={searchQuery}
						placeholder="Search for help..."
						class="w-full rounded-full border-2 border-transparent bg-white px-6 py-5 pr-6 pl-16 text-lg text-slate-900 transition-all outline-none focus:border-[#00E676]"
					/>
				</label>

				<div class="mt-4 flex flex-wrap items-center justify-center gap-4 text-sm text-slate-300">
					<div class="inline-flex items-center gap-2">
						<motion.div
							class="h-2 w-2 rounded-full bg-[#00E676]"
							animate={{ scale: [1, 1.35, 1], opacity: [1, 0.6, 1] }}
							transition={{ duration: 2.2, repeat: Infinity }}
						/>
						<span>{resultCount} help results available</span>
					</div>
					<a href={resolve('/')} class="transition-colors hover:text-[#00E676]">Back to Home</a>
				</div>
			</div>
		</div>
	</div>
</section>
