<script lang="ts">
	import { resolve } from '$app/paths';
	import { Zap } from '@lucide/svelte';
	import { motion } from 'motion-sv';
	import { fade } from 'svelte/transition';
</script>

<section data-nav-theme="dark" class="bg-linear-to-br from-[#0F172A] to-[#1E293B] py-20">
	<div class="mx-auto max-w-4xl px-6 text-center">
		<div in:fade={{ duration: 420 }}>
			<h2 class="font-space-grotesk mb-6 text-4xl font-bold text-white md:text-5xl">
				Still Need Help?
			</h2>
			<p class="mb-10 text-xl text-gray-300">
				Our support team is ready to assist with questions, account issues, and product guidance.
			</p>
			<motion.a
				href={resolve('/contact')}
				whileHover={{ scale: 1.03, y: -2 }}
				whilePress={{ scale: 0.98 }}
				class="font-space-grotesk inline-flex items-center gap-2 rounded-full bg-[#00E676] px-10 py-5 text-lg font-bold text-[#0F172A] shadow-[0_18px_38px_rgba(0,230,118,0.24)] transition-colors hover:bg-emerald-400"
			>
				<Zap size={20} />
				<span>Contact Support</span>
			</motion.a>
		</div>
	</div>
</section>
