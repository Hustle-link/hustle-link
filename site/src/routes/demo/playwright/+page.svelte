<script lang="ts">
	import { resolve } from '$app/paths';
	import BreadCrumbNav from '$lib/components/global/BreadCrumbNav.svelte';
</script>

<main
	class="min-h-screen bg-linear-to-br from-[#0F172A] via-[#111D33] to-[#1E293B]"
	data-nav-theme="dark"
>
	<section class="mx-auto max-w-6xl px-6 pt-28 pb-16">
		<div class="flex min-h-[90vh] flex-col">
			<div class="mb-10">
				<BreadCrumbNav variant="dark" />
			</div>

			<div class="my-auto text-center">
				<h1 class="font-space-grotesk mb-6 text-5xl font-bold text-white md:text-7xl">
					Playwright <span class="text-[#00E676]">E2E Demo</span>
				</h1>
				<p class="mx-auto mb-10 max-w-2xl text-lg text-slate-300 md:text-xl">
					This route is used to validate end-to-end flows and UI behavior in automated browser
					tests.
				</p>
				<a
					href={resolve('/demo')}
					class="font-space-grotesk inline-flex items-center rounded-full border border-[#00E676]/40 px-8 py-4 text-lg font-bold text-[#00E676] transition-colors hover:bg-[#00E676]/10"
				>
					Back to Demo Hub
				</a>
			</div>
		</div>
	</section>
</main>
