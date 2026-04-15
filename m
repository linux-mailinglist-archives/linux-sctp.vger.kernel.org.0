Return-Path: <linux-sctp+bounces-1183-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id lF7cMdSV32nXWQAAu9opvQ
	(envelope-from <linux-sctp+bounces-1183-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Wed, 15 Apr 2026 15:42:44 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4D4404F2B
	for <lists+linux-sctp@lfdr.de>; Wed, 15 Apr 2026 15:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3720430166F6
	for <lists+linux-sctp@lfdr.de>; Wed, 15 Apr 2026 13:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473263A640F;
	Wed, 15 Apr 2026 13:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hI+L4OmU"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EBC2DEA86
	for <linux-sctp@vger.kernel.org>; Wed, 15 Apr 2026 13:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776260473; cv=pass; b=h8ws60RCvsnbWEdFl4kfTvt2y+iQqoqRu8bH/O8ciT52DyGD/2/Tf0EILhqxycNJHzEZndeMcjn5y7cntbdNZZWDJyk/Qgh9bxbgYaM7VhjGDVq6jRRC3fQD2ONjsVkQFc6MlAg4A0AKeEQ8JNRxOOhUCLZKEt6kbSy0YMBSed4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776260473; c=relaxed/simple;
	bh=BLIHgBZrnkQ7vw6Rj0TsGleAI+lWa3AKZNr9AJhe5eY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dpjlpJ/05KKyQj2LhxZFl88oJiH76sS1iMDkCnXWpI9o0h2oNlTnqJVFltP5RdhUAYjKbivkRUicmyAAAFN97CqmZGb0BebNrCSzYkbyiMIJubwugrbAqsysZdQ9wAX+7Uj9/rFpUDfHvHa8DNGyrwSYjtUU3Bvb4WNV5jXg7kQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hI+L4OmU; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c795a88e8acso211138a12.3
        for <linux-sctp@vger.kernel.org>; Wed, 15 Apr 2026 06:41:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776260471; cv=none;
        d=google.com; s=arc-20240605;
        b=AFL/MJ94ub0nYRaBRUE3zrjGVp3yuQ0fegrFZkfs66wIAGhfjUZ/9i1QA4onL/4+QI
         Yiq3wWZa3BjzEpAZXcLU44x1pmC42UPQ9VnXEP2bCJfFYpSNYlQLpELra/tVwzFedl9n
         ATSbeUVUqUXrdifj8G3Le+QTDBDuRMmtDimwv9o9jYsmhwvVg7ocPpUGszdQ2vw2vsiK
         ToCb3BwgjC0DrZTm7/8OzIgc11XlD3CtMFqY8J2IxBKKP/qReSjM21CGEQixrGSV62Ng
         I/NrC6piFh7GyDVt0MrcGS4cGvB/RfzlXAnqb90JEbBrLc7PnNOw9fPgVqMw7ub9GSsR
         sZpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b37utcN63T9QhNWGfa0CC2MuTaxghEDJSSo4dDLN3Xg=;
        fh=SVajpvzGYNq5tsxlwtDykv24Bsnid26Fx2NoNj9OCqo=;
        b=Gwp5Jbav3g5PX+ATD7Ae2O4C3+ZWkoTyzliDdUWjrNCsg2JgrEPwAF5La7SF8wcg/D
         SjY5exGFzhTm5Zx4F6aD6G5a2fxUcED2MwlV8pJoMrUI3JGbO6vwvA0bVhC5lzIN7fjg
         Shg4MO91YjZu//tsCyxOjLKSii83l6YfCh+v3e0Uv71xEtegVWh4wunFoqWvkGCaGX1y
         I3xn8/FOlQnDV3/UZAeW0+cKAPDYmlrFwBh2Dee5PR3GIihW1k3bxGvHlEfWw55eNJXm
         9Oc/mzMUv8Cgb3jgdbUU4Wmh5eBOhj7NTtm72dvtXwS6UnbIXUSFMK9oCxgR+7x9Tuqt
         cveA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776260471; x=1776865271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b37utcN63T9QhNWGfa0CC2MuTaxghEDJSSo4dDLN3Xg=;
        b=hI+L4OmUNm1djuAdz2ITB1URLDMGX8x7WAyy9MTVQYmdubhmstD6z14NjIo1ZvQKGt
         U0QIc2sQgSCvFs3+Z4e+P2Qb+TRkU9Df3uQ8ItgnxO5d/xUi3K/XZzGOy3rjW9wfuOGs
         nw0WkkErpRst6T1QlDIsqrTIVAJdjirzUKvbQL8L62TXo4NL+ZlOp6mvFzH/Y6khUxKa
         Yjjxwbscci6U5svC81EHNlqiFXOsKKjMfCxu6r6/U+zVxXmGMvVNOfww+oS4AVrn4doH
         6BvJEwFtTgh9PsnK+y0AfAwC+j6MZp8p3GVtiPMYGGRwHrQ9pu8jnKigjUmWiIVsmT5o
         fE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776260471; x=1776865271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b37utcN63T9QhNWGfa0CC2MuTaxghEDJSSo4dDLN3Xg=;
        b=oN7BF4siDNOcpraUawifn6uJI6CTswJFrwKf7yK1JEk1p6lZJt3M8JGjlYmLBMCRl/
         NnUmWj5SY/Nck5RTwc2aLQQa3QKRR5PWWnqzjSDFtvNiTw9f2L+XyU4AZqyCE3pkCoU9
         NddotJ9+QCdiVRC3zf7OF4z2/QHy8B+HUIrjirKsvVNBgC+YKMxJC2dieafUvyKjypJs
         +psnvE5XSJwytOB/+Crj7QuMqhzUIdzFlrKb4TPS+P3tVzZEnXI6VkUB2lWqosp2ZHkb
         jWklQ6wuL27EAOsNqd4Ni3FpS9R1ly1RtIf4et1UzoZUY5VlLNhCit5IkXDyTWmI/7sX
         TnIw==
X-Forwarded-Encrypted: i=1; AFNElJ8P69ZPPGjG4xQktS/QN4deBl7ipjD43NsOj2FQ/HGYLZUrkINrZ+1sKQG/RbdpaEKKbgX54BGTB064@vger.kernel.org
X-Gm-Message-State: AOJu0YzazciUzgcpO6l0l21Q41pQ2hxrJWoyavzVAm5z0lIOWNsIianY
	BqrFuHpVioB590NqH/3RMm4bigwRAbGfTifKRU5jcPJsOElxt90mTdyVFypiMc6qbr/axfxJCjq
	b1vBBBMNa5gJowRjX+w25ooskfrYhsBImHRR0CQo=
X-Gm-Gg: AeBDies7+vFP1C1TVYwU/nJ4t4V4wH1ZFRFDWrCHsES4V1LC8VwRaC4UZa4Jc5bmn3N
	r8/rS3hUC0qIlSnoAfAD0yfZyC9a2hoqpaHeEpQ8kP9wznUbO4YCuNHAqvOZo+nvZC2hIUO4OYS
	tQG0DpOloqgQvSM54TO/KE59wMk/lqcivhYHV9YqV1bAZ6Sceuns8hj8N7a92BWyMgqpnnhjaQD
	36F2Zkn0itGhcwmYGuK3li5qKa7wyxGSABztNTSvf0Om7BEkrI10LBrx/ucVxzGUk82SEkUb6J3
	PPIWLDHq39pKSI1qWJcwB6YFEHZlLKQ/yFFluugrJlZcRAYhka0hkcCpwcS2wnC/SUP9QHih26B
	H1EG6TE48GsWyNGwnSQ==
X-Received: by 2002:a05:6a20:3d1c:b0:398:9379:d056 with SMTP id
 adf61e73a8af0-39fe3cf754cmr23718037637.16.1776260470759; Wed, 15 Apr 2026
 06:41:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7e897c44.4cb35.19d8f29411c.Coremail.xudongjie25@mails.ucas.ac.cn>
In-Reply-To: <7e897c44.4cb35.19d8f29411c.Coremail.xudongjie25@mails.ucas.ac.cn>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 15 Apr 2026 09:40:59 -0400
X-Gm-Features: AQROBzA_GcgXLsh9-gX0CcNjHPxv4CVKZtECXb_27tAljyeG-5HqqNCAANfBvnU
Message-ID: <CADvbK_dbiS2Y9nQ5878QZvN-KPs+ZeeX5e2hQsJRyXb=a11MQQ@mail.gmail.com>
Subject: Re: [BUG] KASAN: slab-use-after-free in sctp_addto_chunk
To: =?UTF-8?B?6K645Lic5rSB?= <xudongjie25@mails.ucas.ac.cn>
Cc: marcelo.leitner@gmail.com, linux-sctp@vger.kernel.org, 
	netdev@vger.kernel.org, zhaoruilin22@mails.ucas.ac.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1183-lists,linux-sctp=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,mails.ucas.ac.cn];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-sctp];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,ucas.ac.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB4D4404F2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 11:23=E2=80=AFPM =E8=AE=B8=E4=B8=9C=E6=B4=81 <xudon=
gjie25@mails.ucas.ac.cn> wrote:
>
> Hi,
>
> While running fuzzing tests on 6.19.0-rc5, we hit a slab-use-after-free i=
n the SCTP module. The crash occurs in skb_put_data() when processing an in=
coming chunk and appending data via sctp_addto_chunk().
>
> Looking at the trace and the code, it seems to be an skb reallocation iss=
ue. In sctp_sf_beat_8_3(), a pointer to the payload is extracted from the i=
ncoming chunk's skb. Later, a pull operation (e.g., pskb_pull) might trigge=
r pskb_expand_head(), which frees the original skb->head and reallocates a =
larger one. However, the previously extracted payload pointer becomes dangl=
ing but is still passed down to sctp_make_heartbeat_ack(), eventually being=
 read by memcpy() in skb_put_data().
>
Hi, Dongjie,

Normally this shouldn't happen, as all incoming skbs must have already
been linearized in sctp_rcv() before coming to  sctp_sf_beat_8_3().
For a linearized skb, pskb_pull() will not trigger the skb
reallocation, but only reduce skb->len and advance skb->data.

Do you have a reproducer to trigger this issue? We need to check how a
non-linearized skb arrives in sctp_sf_beat_8_3().

Thanks.

> It seems we need to either ensure pull operations are completed before ta=
king the payload pointer, or recalculate the pointer immediately after the =
pull.
>
> We haven't prepared a patch for this yet, but we are glad to help test an=
y proposed fixes.
>
> Crash log, call trace, and machine info are as follows:
>
> [Machine Info]
> QEMU emulator version 6.2.0
> CPU: Intel(R) Xeon(R) Gold 5218 CPU @ 2.30GHz (4 cores)
> Kernel Version: 6.19.0-rc5-00042-g944aacb68baf
>
> [Crash Report & Call Trace]
> BUG: KASAN: slab-use-after-free in skb_put_data include/linux/skbuff.h:28=
00 [inline]
> BUG: KASAN: slab-use-after-free in sctp_addto_chunk+0xfa/0x2a0 net/sctp/s=
m_make_chunk.c:1535
> Read of size 56 at addr ffff88804878bb68 by task syz.6.114/15386
>
> CPU: 3 UID: 0 PID: 15386 Comm: syz.6.114 Not tainted 6.19.0-rc5-00042-g94=
4aacb68baf #1 PREEMPT(full)
> Call Trace:
> <TASK>
> __dump_stack lib/dump_stack.c:94 [inline]
> dump_stack_lvl+0x116/0x1b0 lib/dump_stack.c:120
> print_address_description mm/kasan/report.c:378 [inline]
> print_report+0xca/0x5f0 mm/kasan/report.c:482
> kasan_report+0xca/0x100 mm/kasan/report.c:595
> check_region_inline mm/kasan/generic.c:194 [inline]
> kasan_check_range+0x39/0x1c0 mm/kasan/generic.c:200
> __asan_memcpy+0x24/0x60 mm/kasan/shadow.c:105
> skb_put_data include/linux/skbuff.h:2800 [inline]
> sctp_addto_chunk+0xfa/0x2a0 net/sctp/sm_make_chunk.c:1535
> sctp_make_heartbeat_ack+0x54/0x110 net/sctp/sm_make_chunk.c:1198
> sctp_sf_beat_8_3+0x4f6/0x7a0 net/sctp/sm_statefuns.c:1201
> sctp_do_sm+0x172/0x5520 net/sctp/sm_sideeffect.c:1172
> sctp_assoc_bh_rcv+0x38a/0x6c0 net/sctp/associola.c:1034
> sctp_inq_push+0x1dc/0x270 net/sctp/inqueue.c:88
> sctp_backlog_rcv+0x167/0x5a0 net/sctp/input.c:331
> sk_backlog_rcv include/net/sock.h:1177 [inline]
> __release_sock+0x397/0x430 net/core/sock.c:3213
> release_sock+0x5a/0x220 net/core/sock.c:3795
> ...
> </TASK>
>
> Freed by task 15386: kasan_save_stack+0x24/0x50 mm/kasan/common.c:57 kasa=
n_save_track+0x14/0x30 mm/kasan/common.c:78 kasan_save_free_info+0x3b/0x60 =
mm/kasan/generic.c:584 poison_slab_object mm/kasan/common.c:253 [inline] __=
kasan_slab_free+0x61/0x80 mm/kasan/common.c:285 kasan_slab_free include/lin=
ux/kasan.h:235 [inline] slab_free mm/slub.c:6670 [inline] kmem_cache_free+0=
x15f/0x780 mm/slub.c:6781 skb_kfree_head net/core/skbuff.c:1066 [inline] sk=
b_free_head+0x1b7/0x210 net/core/skbuff.c:1080 pskb_expand_head+0x3b1/0xf80=
 net/core/skbuff.c:2314 skb_might_realloc+0xb1/0xd0 net/core/skb_fault_inje=
ction.c:33 pskb_may_pull_reason include/linux/skbuff.h:2850 [inline] pskb_p=
ull include/linux/skbuff.h:2871 [inline] sctp_sf_beat_8_3+0x419/0x7a0 net/s=
ctp/sm_statefuns.c:1198 ...
> Xu Dongjie
> University of Chinese Academy of Sciences

