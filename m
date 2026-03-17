Return-Path: <linux-sctp+bounces-1137-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IM5Hx0vuWlzuAEAu9opvQ
	(envelope-from <linux-sctp+bounces-1137-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 17 Mar 2026 11:38:21 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 612F62A80F1
	for <lists+linux-sctp@lfdr.de>; Tue, 17 Mar 2026 11:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 849C53064CFC
	for <lists+linux-sctp@lfdr.de>; Tue, 17 Mar 2026 10:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAD23A6EF0;
	Tue, 17 Mar 2026 10:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CRhIAl2f"
X-Original-To: linux-sctp@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160603A6EEF
	for <linux-sctp@vger.kernel.org>; Tue, 17 Mar 2026 10:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773743687; cv=none; b=Id6qMwBiXILbuvJVoTwzDqkKZZpDdCzAiBNHiFXFZES5yDnmCMjPZ+CplADnXZMnxtFODdHQYeYTDjrcQsHmNRJuuLoYR75E3Slc/dFD0hKLEso9q0jbhJ1tuh1lTm7Q5IHFK3VnjQBkO4HKr/Z85vmA1HZus31DMi64qHiIsK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773743687; c=relaxed/simple;
	bh=cOJ0pqLB05cW7l8D0d5y/xnlGOGTKB72z83QuCFoWlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ggw/869W42wSHlP9bQcHomGWu9SM4Phx09oxafau15YylD3+Vba4q07l8u9GPEhB4b0F2i1tVme9lhEGj9E6H7BkHkeE7WYqLmku3KSjEecbVw6kpP5cek4lfTxeg1wKPLC5QnFgtBLRFasCKKzmCJ80XLLl8Y/hWCnKpNfccmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CRhIAl2f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773743685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ny0IuTqhujPnnvktMKwVQKRIYww+FI37mlIAqoGoFS8=;
	b=CRhIAl2fIPD+9Zy9h0eoRCjxNxwJZCHNhieCDyVKw+pk0ulC2P8ZQ0r3WiqH4F/4t9+Jir
	RDCIYJcIzYKbORr69wetXv612iqpo43JDWxSPFZDSE+/5GiqtjwMB/VsgGJFdTq6BUZfLC
	4JaosOAdwLARoIXbDE5nd5UkMesDN1w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-ek8yyXpBNo2-U2VHrZyKCQ-1; Tue, 17 Mar 2026 06:34:44 -0400
X-MC-Unique: ek8yyXpBNo2-U2VHrZyKCQ-1
X-Mimecast-MFC-AGG-ID: ek8yyXpBNo2-U2VHrZyKCQ_1773743683
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43b42cd4becso415718f8f.1
        for <linux-sctp@vger.kernel.org>; Tue, 17 Mar 2026 03:34:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773743683; x=1774348483;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ny0IuTqhujPnnvktMKwVQKRIYww+FI37mlIAqoGoFS8=;
        b=dPCKRapWDwZeUIH4YjVHAXvZHti8NoSzh3zW00TPEIeZylCd0BcKSof8eUYZ8bsr/g
         +0zGJtKXs+OdqLRSlcFPxjocLEtpsCH1SJeBf1SN0JLRAU3n+Dd/4+4uUm4SlV6/pbZl
         kRpT00blnD4WkINrcZMem0j+3nuT5HQuiRgfMsJn+xEM5xuBrTresircyKwrDGSgrong
         na8//X/GW75r4NZV0y7sFLjUyrUFvd8ymsCBOFeYBmbC7pDZfDuOSntd5HOeFw5IpzV0
         ui/l0csCZ8FywuwEvqJlHPZ/dzIFBqJyI4M4ZqRieFHtUO4dAHAFfpGfYeDE0ofxcLrO
         yTMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEab1CM8HFX7MZll2wFPEAj1BPiB5DfbdEACMeZt981iK52M+84OuWF+aCmx0nlVvj+ucz6HJ3AeZb@vger.kernel.org
X-Gm-Message-State: AOJu0YxJPUIULoDJvDrOqJvHywbVHqx9VO6tb3ny1Sjc5WsbNjbHLnzW
	A7HI5SekWaIT8bDBVkB/fnO1zo29RER5HKrWbqIJw8nOlOEsXRg0Iy1DasCGe0h2pfImvgFhePO
	de/QHZbVpiFO867svhOSED845J4FoeJMCSTLC5NJk4b029jCk6U9l2f8+tKMyQPA=
X-Gm-Gg: ATEYQzxOlNN21OafX+sPrQhyuBsLwEnhFHxBu0lyi+AConRc4sdu/20Y4dvjkGfn2OL
	htUEzvQ0ieVPfnsQhQsv5pT8Qzw4rSyKRtfVmhPILoLI3Vyw5+4G+WQs6yJtXWpxnzuInHfnZG/
	2TwiJeiNERNnBak941EU6kjtHUViMUepgM08pNAcCBWBncP0YtZlm6quSkvuBAlutZHAVQ1Chxl
	/HbbNhAAK5I+wsZWYa4irkjUdKEFPnPisCQP5jD6aZE0mIWW3xWADeKGBa4AbAXbMIWykUauN6X
	aa7vnuISL24xGPrPmOU/Z7DlozBcBEJQwv3/kWwle0UcdOFe+gJYZUDR+Lk9HG4YWBgZIMgn8fW
	MjVJ45HkQJeRiINW7C+IUk33RHuaSLDVS0OOp/XB85dPttXLO/TZSULM=
X-Received: by 2002:a5d:5d06:0:b0:439:9812:35ea with SMTP id ffacd0b85a97d-43b498127a9mr5655210f8f.3.1773743682886;
        Tue, 17 Mar 2026 03:34:42 -0700 (PDT)
X-Received: by 2002:a5d:5d06:0:b0:439:9812:35ea with SMTP id ffacd0b85a97d-43b498127a9mr5655135f8f.3.1773743682342;
        Tue, 17 Mar 2026 03:34:42 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b3e9a4fcdsm22271699f8f.8.2026.03.17.03.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 03:34:41 -0700 (PDT)
Message-ID: <19078c41-5ee8-402a-9b60-fc4ab0fb8ece@redhat.com>
Date: Tue, 17 Mar 2026 11:34:34 +0100
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/15] net: Use trace_invoke_##name() at guarded
 tracepoint call sites
To: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Peter Zijlstra <peterz@infradead.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Xin Long <lucien.xin@gmail.com>, Jon Maloy <jmaloy@redhat.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Samiullah Khawaja <skhawaja@google.com>, Hangbin Liu <liuhangbin@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 dev@openvswitch.org, linux-sctp@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-trace-kernel@vger.kernel.org
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
 <20260312150523.2054552-5-vineeth@bitbyteword.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260312150523.2054552-5-vineeth@bitbyteword.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5RsPvIUxIXnbINb4xM-KvX4PEYzynGMP5XvnwsMZ_0o_1773743683
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[goodmis.org,infradead.org,davemloft.net,google.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,redhat.com,ovn.org,vger.kernel.org,openvswitch.org,lists.sourceforge.net];
	TAGGED_FROM(0.00)[bounces-1137-lists,linux-sctp=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-sctp@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-sctp];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bitbyteword.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Queue-Id: 612F62A80F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/12/26 4:04 PM, Vineeth Pillai (Google) wrote:
> Replace trace_foo() with the new trace_invoke_foo() at sites already
> guarded by trace_foo_enabled(), avoiding a redundant
> static_branch_unlikely() re-evaluation inside the tracepoint.
> trace_invoke_foo() calls the tracepoint callbacks directly without
> utilizing the static branch again.
> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> Assisted-by: Claude:claude-sonnet-4-6

Side question: which is the merge plan here? since this patch depends on
1/15 I guess it's via the trace tree, am I correct?

/P


