Return-Path: <linux-sctp+bounces-1222-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEdoDqcLGGpzbAgAu9opvQ
	(envelope-from <linux-sctp+bounces-1222-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Thu, 28 May 2026 11:32:23 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 905BC5EFA43
	for <lists+linux-sctp@lfdr.de>; Thu, 28 May 2026 11:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1E7933E1179
	for <lists+linux-sctp@lfdr.de>; Thu, 28 May 2026 09:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D878F388878;
	Thu, 28 May 2026 09:13:17 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6719377EBA;
	Thu, 28 May 2026 09:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779959597; cv=none; b=NLIcCNmcVHioRrE37gLFMSPQN6Cf0+gCp+d2Ef3JiFSLEhcG0JM2wOivG0O0C1xDHiMxXewvP/TdRhoFyOFw3/2992mrEnU7BbVAgrEKYu0WM1njKZ3kavDvQn4IOkSyahDGeV5PzzlJ0gEDH7OHf29vdznmNEtv6vYdmTJDvpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779959597; c=relaxed/simple;
	bh=rkwYo30qpTvqS00hy6/fWw4cQopOehQnCR6wAEP0gNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YSEYYUwer22lyYbRZ1oZMBwMh4eTm0iOGg2TTnl6wnTXX++SlgRCKRJbptFQYCb6E6YB+hMeO5yauXXR8wfwcSqRVFhyCMtMGSpxC/LHGvwUQZGUIjSPJP1+XzCLG57Tndpz7umsnXeiM5DRBP/avXGdqiy1y0JOiCQJhUJC+hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from [IPV6:fdfe:dcba:9876::1] (unknown [172.23.56.36])
	by app2 (Coremail) with SMTP id zQmowABnAwsdBxhqRsYRAA--.39415S2;
	Thu, 28 May 2026 17:13:01 +0800 (CST)
Message-ID: <602e2a54-f5e2-43a2-95ad-d7f6adb11eeb@lzu.edu.cn>
Date: Thu, 28 May 2026 17:13:01 +0800
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] sctp: stream: clear current stream on stream
 teardown
To: linux-sctp@vger.kernel.org, netdev@vger.kernel.org
Cc: marcelo.leitner@gmail.com, lucien.xin@gmail.com, davem@davemloft.net,
 yuantan098@gmail.com, yifanwucs@gmail.com, tomapufckgml@gmail.com,
 zcliangcn@gmail.com, bird@lzu.edu.cn, xuyq21@lenovo.com
References: <cover.1779644468.git.xuyq21@lenovo.com>
 <ad9d7027579442c6c9498e7af84f836747a7620e.1779644468.git.xuyq21@lenovo.com>
Content-Language: en-US
From: Ren Wei <n05ec@lzu.edu.cn>
In-Reply-To: <ad9d7027579442c6c9498e7af84f836747a7620e.1779644468.git.xuyq21@lenovo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zQmowABnAwsdBxhqRsYRAA--.39415S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFy8WFWxXw17Kr47Xr1kXwb_yoW8CryfpF
	Z7uw4ftF97JFyxGrn7Aw1FqF1Fgw4kJw47KF90kF1DZF4DGFyFqFyvgFWkJr1kCr409r42
	yrn0q347tw45Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9lb7Iv0xC_Cr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI
	0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWU
	tVW8ZwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8GwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUzOJ5UUUUU
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQsBCWoX+s4A+wABsx
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,lzu.edu.cn,lenovo.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1222-lists,linux-sctp=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DMARC_NA(0.00)[lzu.edu.cn];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,linux-sctp@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.988];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lzu.edu.cn:mid,lzu.edu.cn:email,lenovo.com:email]
X-Rspamd-Queue-Id: 905BC5EFA43
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/28/26 16:58, Ren Wei wrote:
> From: Yuqi Xu <xuyq21@lenovo.com>
> 
> out_curr caches the outbound stream currently being dequeued. When the
> stream table is replaced, the old stream entries and their ext state
> are freed, so keeping out_curr leaves scheduler state pointing at
> released stream storage.
> 
> Clear out_curr in sctp_stream_free(), where the backing stream entries
> are torn down. This keeps the cached scheduler state aligned with the
> lifetime of the stream table for stream updates and any other full
> stream teardown paths.
> 
> Fixes: 5bbbbe32a431 ("sctp: introduce stream scheduler foundations")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Assisted-by: Codex:GPT-5.4
> Signed-off-by: Yuqi Xu <xuyq21@lenovo.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
>  net/sctp/stream.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/sctp/stream.c b/net/sctp/stream.c
> index c2247793c88b..207e0a77f9af 100644
> --- a/net/sctp/stream.c
> +++ b/net/sctp/stream.c
> @@ -186,6 +186,7 @@ void sctp_stream_free(struct sctp_stream *stream)
>  	int i;
>  
>  	sched->unsched_all(stream);
> +	stream->out_curr = NULL;
>  	for (i = 0; i < stream->outcnt; i++)
>  		sctp_stream_free_ext(stream, i);
>  	genradix_free(&stream->out);

We sincerely apologize for the repeated duplicate postings.

We did not manage the posting state carefully on our side and
ended up sending this series multiple times by mistake. This was
entirely our fault, and we are sorry for the unnecessary noise
and disruption.

Please ignore the extra copies.

Best regards,
Ren Wei


