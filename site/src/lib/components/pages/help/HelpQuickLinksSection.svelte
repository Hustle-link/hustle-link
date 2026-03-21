<script lang="ts">
	import { motion } from 'motion-sv';
	import type { QuickLink } from './help.types';

	interface Props {
		quickLinks: QuickLink[];
	}

	let { quickLinks }: Props = $props();
</script>

<section data-nav-theme="light" class="bg-gray-50 py-16">
	<div class="mx-auto max-w-7xl px-6">
		<div class="grid gap-8 md:grid-cols-3">
			{#each quickLinks as item, index (item.id)}
				<motion.a
					href={item.href}
					initial={{ opacity: 0, y: 24 }}
					animate={{ opacity: 1, y: 0 }}
					transition={{ delay: index * 0.1, duration: 0.4 }}
					whileHover={{ y: -6, scale: 1.01 }}
					whilePress={{ scale: 0.98 }}
					class="rounded-3xl border border-gray-200 bg-white p-8 text-center shadow-[0_16px_42px_rgba(15,23,42,0.05)] transition-colors hover:border-[#00E676]"
				>
					<div
						class="mx-auto mb-4 flex h-16 w-16 items-center justify-center rounded-2xl bg-linear-to-br from-[#00E676] to-emerald-400 text-white"
					>
						<item.icon size={32} />
					</div>
					<h2 class="font-space-grotesk mb-2 text-2xl font-bold text-[#0F172A]">{item.title}</h2>
					<p class="text-gray-600">{item.description}</p>
				</motion.a>
			{/each}
		</div>
	</div>
</section>
