<script>
	import { motion } from 'motion-sv';
	import { ArrowRight } from '@lucide/svelte';
	import { goto } from '$app/navigation';

	const globeRings = [
		{ insetRem: 0, borderColor: 'rgba(0, 230, 118, 0.2)' },
		{ insetRem: 1, borderColor: 'rgba(0, 230, 118, 0.15)' },
		{ insetRem: 2, borderColor: 'rgba(0, 230, 118, 0.1)' }
	];
</script>

<motion.section
	id="hero"
	data-nav-theme="dark"
	class="relative top-0 min-h-screen w-full overflow-hidden bg-linear-to-br from-[#0F172A] via-[#1E293B] to-[#0F172A]"
>
	<!-- Animated Background Elements -->
	<div class="absolute inset-0 overflow-hidden">
		<motion.div
			class="absolute top-20 left-10 h-72 w-72 rounded-full bg-[#00E676] opacity-10 blur-[100px]"
			animate={{
				x: [0, 100, 0],
				y: [0, 50, 0]
			}}
			transition={{ duration: 20, repeat: Infinity }}
		/>
		<motion.div
			class="absolute right-10 bottom-20 h-96 w-96 rounded-full bg-emerald-400 opacity-10 blur-[120px]"
			animate={{
				x: [0, -80, 0],
				y: [0, -60, 0]
			}}
			transition={{ duration: 25, repeat: Infinity }}
		/>
	</div>

	<!-- 3D Globe Background -->
	<div class="absolute top-1/2 left-1/2 h-150 w-150 -translate-x-1/2 -translate-y-1/2">
		<motion.div
			class="relative h-full w-full"
			animate={{ rotate: 360 }}
			transition={{ duration: 60, repeat: Infinity, ease: 'linear' }}
		>
			{#each globeRings as ring, index (`globe-ring-${index}`)}
				<span
					class="absolute rounded-full border"
					style={`inset: ${ring.insetRem}rem; border-color: ${ring.borderColor};`}
				></span>
			{/each}

			<!-- Botswana Pulse Point -->
			<motion.div
				class="absolute top-1/2 left-1/2 h-4 w-4 rounded-full bg-[#00E676]"
				animate={{
					scale: [1, 1.5, 1],
					opacity: [1, 0.5, 1]
				}}
				transition={{ duration: 2, repeat: Infinity }}
			>
				<div class="absolute inset-0 animate-ping rounded-full bg-[#00E676]"></div>
			</motion.div>

			<!-- Live Job Hotspots -->
			{#each Array.from({ length: 6 }, (_, i) => i) as i (i)}
				<motion.div
					class="absolute h-2 w-2 rounded-full bg-emerald-400"
					initial={{
						top: `${30 + Math.random() * 40}%`,
						left: `${30 + Math.random() * 40}%`
					}}
					animate={{
						scale: [1, 1.3, 1],
						opacity: [0.7, 1, 0.7]
					}}
					transition={{
						duration: 2,
						delay: i * 0.3,
						repeat: Infinity
					}}
				/>
			{/each}
		</motion.div>
	</div>

	<!-- Main Content -->
	<div class="relative z-10 mx-auto max-w-7xl px-6 pt-32 pb-20">
		<!-- Hero Content -->
		<div class="mx-auto max-w-4xl text-center">
			<motion.h1
				initial={{ opacity: 0, y: 30 }}
				animate={{ opacity: 1, y: 0 }}
				transition={{ duration: 0.8 }}
				class="font-space-grotesk mb-6 text-6xl leading-tight font-bold text-white md:text-8xl"
			>
				Your Skills. <span class="text-[#00E676]">Our Links.</span>
				<br />
				<motion.span
					initial={{ opacity: 0, y: 20 }}
					animate={{ opacity: 1, y: 0 }}
					transition={{ delay: 0.3, duration: 0.8 }}
				>
					The Hustle Refined.
				</motion.span>
			</motion.h1>

			<motion.p
				initial={{ opacity: 0, y: 20 }}
				animate={{ opacity: 1, y: 0 }}
				transition={{ delay: 0.5, duration: 0.8 }}
				class="mx-auto mb-12 max-w-2xl text-xl text-gray-300"
			>
				Botswana's #1 AI-powered platform matching your certifications to real Pula-making
				opportunities.
			</motion.p>

			<!-- Magnetic CTA Button -->
			<motion.button
				initial={{ opacity: 0, y: 20 }}
				animate={{ opacity: 1, y: 0 }}
				transition={{ delay: 0.7, duration: 0.8 }}
				whileHover={{ scale: 1.05 }}
				whilePress={{ scale: 0.95 }}
				class="group font-space-grotesk relative overflow-hidden rounded-full bg-[#00E676] px-10 py-5 text-lg font-bold text-[#0F172A]"
				onclick={() => goto('/download')}
			>
				<motion.div
					class="absolute inset-0 bg-linear-to-r from-emerald-300 to-emerald-500"
					initial={{ x: '-100%' }}
					whileHover={{ x: 0 }}
					transition={{ duration: 0.3 }}
				/>
				<span class="relative z-10 flex items-center gap-2">
					Secure the Bag
					<ArrowRight class="transition-transform group-hover:translate-x-1" size={20} />
				</span>
				<motion.div
					class="absolute inset-0 rounded-full"
					animate={{
						boxShadow: [
							'0 0 20px rgba(0, 230, 118, 0.5)',
							'0 0 40px rgba(0, 230, 118, 0.8)',
							'0 0 20px rgba(0, 230, 118, 0.5)'
						]
					}}
					transition={{ duration: 2, repeat: Infinity }}
				/>
			</motion.button>

			<!-- Floating Skill Cloud -->
			<div class="relative mt-20 flex h-40 items-center justify-center">
				{#each [{ icon: '💻', label: 'Coding', x: -150, y: 0 }, { icon: '☀️', label: 'Solar Tech', x: 150, y: 0 }, { icon: '🎨', label: 'Creative Arts', x: -100, y: 60 }, { icon: '💰', label: 'Finance', x: 100, y: 60 }] as skill, i (i)}
					<motion.div
						class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2"
						style={{ x: skill.x, y: skill.y }}
						animate={{
							y: [skill.y, skill.y - 20, skill.y]
						}}
						transition={{
							duration: 3,
							delay: i * 0.2,
							repeat: Infinity
						}}
					>
						<div
							class="flex items-center gap-3 rounded-2xl border border-white/20 bg-white/10 px-6 py-3 backdrop-blur-md"
						>
							<span class="text-3xl">{skill.icon}</span>
							<span class="font-medium text-white">{skill.label}</span>
						</div>
					</motion.div>
				{/each}
			</div>
		</div>
	</div>

	<!-- Scroll Indicator -->
	<motion.div
		class="absolute bottom-10 left-1/2 -translate-x-1/2"
		animate={{ y: [0, 10, 0] }}
		transition={{ duration: 2, repeat: Infinity }}
	>
		<div class="flex h-10 w-6 justify-center rounded-full border-2 border-[#00E676] pt-2">
			<motion.div
				class="h-2 w-1 rounded-full bg-[#00E676]"
				animate={{ y: [0, 12, 0] }}
				transition={{ duration: 2, repeat: Infinity }}
			/>
		</div>
	</motion.div>
</motion.section>
