<script lang="ts">
	import { resolve } from '$app/paths';
	import BreadCrumbNav from '$lib/components/global/BreadCrumbNav.svelte';
</script>

<main
	class="min-h-screen bg-linear-to-br from-[#0F172A] via-[#1E293B] to-[#0F172A]"
	data-nav-theme="dark"
>
	<section class="mx-auto max-w-6xl px-6 pt-28 pb-16">
		<div class="flex min-h-[90vh] flex-col">
			<div class="mb-10">
				<BreadCrumbNav variant="dark" />
			</div>

			<div class="my-auto text-center">
				<h1 class="font-space-grotesk mb-6 text-5xl font-bold text-white md:text-7xl">
					HustleLink <span class="text-[#00E676]">Demo</span>
				</h1>
				<p class="mx-auto mb-10 max-w-2xl text-lg text-slate-300 md:text-xl">
					Use this demo hub to navigate into testing and preview routes.
				</p>
				<a
					href={resolve('/demo/playwright')}
					class="font-space-grotesk inline-flex items-center rounded-full bg-[#00E676] px-8 py-4 text-lg font-bold text-[#0F172A] transition-colors hover:bg-emerald-400"
				>
					Open Playwright Demo
				</a>
			</div>
		</div>
	</section>
</main>
