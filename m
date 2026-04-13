Return-Path: <linux-sctp+bounces-1175-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLkKGDPj3GnBXwkAu9opvQ
	(envelope-from <linux-sctp+bounces-1175-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Mon, 13 Apr 2026 14:36:03 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6E33EC083
	for <lists+linux-sctp@lfdr.de>; Mon, 13 Apr 2026 14:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CEC5930073CC
	for <lists+linux-sctp@lfdr.de>; Mon, 13 Apr 2026 12:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A58352C29;
	Mon, 13 Apr 2026 12:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McPOd93B"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7F53C344F
	for <linux-sctp@vger.kernel.org>; Mon, 13 Apr 2026 12:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776083759; cv=none; b=I1rfLWYanbFPd8rnGMXnddcUH5Tn/opZq73/GVtjqUoJXy4LYjGAYd4wa4UrZRcmzX8XLAw4ku5BhSVd7paTSvZUvIT0bVcu/WOQ1Rzr1ICgkqcrZEM3HPoQdN3ldXoImgclbKpR4U2rTdr/TJmxSv1KFxXsEMIWJx2lvE+Zt1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776083759; c=relaxed/simple;
	bh=wSf6VAnTCTO1T0uZGOePk0LYzgJ24D1ML1VNTX2a2OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hw+I7BTU4qLYUdrrlM8llkaNI0X3tyZuntkQ3QMXiFcMluFP/otsNuOI0R9Z+d9pep5Vex8YWSBwkfSvAt6tfqC9ZToLNAFwgFWzeJwKgWXRB5IwDAmsQdmeJXlnhCNwbClUabW1RszUv3FLlnyUkcLhtwRAFjadtlXXc29kBwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=McPOd93B; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2d9916deb14so1097029eec.0
        for <linux-sctp@vger.kernel.org>; Mon, 13 Apr 2026 05:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776083758; x=1776688558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bNu4mYE1I6cyCFIALOH7cir6PiU714YUZNoVaspB8QI=;
        b=McPOd93BPHFRGOvFsndutKRXzAv57SlDwW8CBhB2nXRUEg7S5jiwAVD1pphbXhwOZl
         Nc8aQxXgiarxmx7ma3vJzGYoHcyNowoxeRhsGiFtf/YRN8F0SgIomlZ/v04XEyQ00ACp
         dWHadN7+k4qjgqJWXQ/uCUnlSLlNL6GP6PepGh47GS8LExqSDsmYTQBT3pqSDjAPdAX1
         FPnWLK4QXlke2OPJK5KF04tO+Rf3b3t9WFYuOUuAiFwBFFAu1P+hg+UT6gd16blMjgfo
         /aKkW6MnmO/HkpqVcmftw8WERL4l21DsmpaTj+UQclX5InOaiOGm4dHgbcBmoRE+Skw5
         D2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776083758; x=1776688558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bNu4mYE1I6cyCFIALOH7cir6PiU714YUZNoVaspB8QI=;
        b=oLzgmZxoNfk2MaBG50wzJsY7Prhy2rmx5BGKmZLiywMtnqxuP4C17CQodO5SwrbqJN
         icLOcKOqowWZzg8DSjn2soav+YVHvuT1khwJ4z7p9am+IX7Qma/JrK8ou1I4LAl8R3Di
         Tcg3edPSBK9q+OATP2Rk3PrSH1f0XmlaNTg7Zn7SeW+bcHL5KUOgMEOHkC5t5pemS7jH
         FC6NtVkAh9rbGrGsjeNjjb4bLo6hEjCt4FNplb+lPcluzRWG0loCsnz2Q0noZ6mYAwi9
         DrFGCWdpBXmYvbYYkoL58jhsiqHP96W67nOHBaQiDUMGk/iIWNVNcmO3Upedgy2x/K8g
         RI4g==
X-Forwarded-Encrypted: i=1; AFNElJ8Dy055dr85t1HpuGGmm1LDr9hZvKfVK1abw/M05rcHvpF0NhOGDMXJfSlZDShzVJNqOmBQkKCGrlLu@vger.kernel.org
X-Gm-Message-State: AOJu0YxS4Zf4j93NlKnP7t94Ete0LK2tWJp6Z/JtpA7+h/wK6shg/4QY
	YtmmlBCjy434YhXRijfO++yRIGz5uLMqT+JQINA8O8pr26c2JdlkZ/j5
X-Gm-Gg: AeBDiesNhGaeIAuq3s/zqzYoJRTb8XYBD8Fj1DOeIfRAGanBF+ItKIvbAIVrwM7z4+P
	tfofp0WRoy+7jH1qnBwOU07tjQUZuTismtUIB6oeqzzXixAwLZ3IraNQy/Yzu1yLr/Rkl1uOaQ1
	jXXsrke9f6+UVIZTV48fG9YwCu0g5cfnRSck+cO0zRxKGzUbriHeGmBzChWnEUVnT8ClTF/obXJ
	Iv7HCcn+gYRHR3kjnus+qEVDS5B5JsGsACEVItBxlXvTM5CKYZkT3k8UR1uwpRxlO2LQMnc+LSy
	ham/SDRwWbCulRlwhZIYJlKnU9dmiUI/GMwVfmYVq/BAerNbWUdJw/orMb6vC4rHiMqb3P6MMgk
	xL9dg77BqbHeFrYQ7BwRCuMWNF679jCJLIh1RqtFKs9Opxn+w9/Bmw/ihn3/8lOdKkRwi660MMf
	rdqdQdcxeDwgw2ZZxPN1vJtAj0rr5gi961Olw2MQ==
X-Received: by 2002:a05:7300:3247:b0:2c7:2c0b:f33b with SMTP id 5a478bee46e88-2d5899a3bafmr7369419eec.20.1776083757600;
        Mon, 13 Apr 2026 05:35:57 -0700 (PDT)
Received: from t14s.localdomain ([177.37.143.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d851e5bb3csm7691505eec.1.2026.04.13.05.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 05:35:57 -0700 (PDT)
Received: by t14s.localdomain (Postfix, from userid 1000)
	id 4A4C613FAC00; Mon, 13 Apr 2026 09:35:54 -0300 (-03)
Date: Mon, 13 Apr 2026 09:35:54 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>, linux-sctp@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>,
	Yi Chen <yiche@redhat.com>
Subject: Re: [PATCH net 1/2] netfilter: skip recording stale or retransmitted
 INIT
Message-ID: <adzjKiDngz_DiJqD@t14s.localdomain>
References: <cover.1775847557.git.lucien.xin@gmail.com>
 <6e09f9a8d1f13f3ce691c696d3dd7b2a2e6c6184.1775847557.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e09f9a8d1f13f3ce691c696d3dd7b2a2e6c6184.1775847557.git.lucien.xin@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1175-lists,linux-sctp=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marceloleitner@gmail.com,linux-sctp@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-sctp];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,t14s.localdomain:mid]
X-Rspamd-Queue-Id: DE6E33EC083
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 02:59:16PM -0400, Xin Long wrote:
> An INIT whose init_tag matches the peer's vtag does not provide new state
> information. It indicates either:
> 
> - a stale INIT (after INIT-ACK has already been seen on the same side), or
> - a retransmitted INIT (after INIT has already been recorded on the same
>   side).
> 
> In both cases, the INIT must not update ct->proto.sctp.init[] state, since
> it does not advance the handshake tracking and may otherwise corrupt
> INIT/INIT-ACK validation logic.
> 
> Allow INIT processing only when the conntrack entry is newly created
> (SCTP_CONNTRACK_NONE), or when the init_tag differs from the stored peer
> vtag.
> 
> Note it skips the check for the ct with old_state SCTP_CONNTRACK_NONE in
> nf_conntrack_sctp_packet(), as it is just created in sctp_new() where it
> set ct->proto.sctp.vtag[IP_CT_DIR_REPLY] = ih->init_tag.
> 
> Fixes: 9fb9cbb1082d ("[NETFILTER]: Add nf_conntrack subsystem.")
> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>

