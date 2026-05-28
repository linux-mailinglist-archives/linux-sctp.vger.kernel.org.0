Return-Path: <linux-sctp+bounces-1221-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEGbJgIJGGoaawgAu9opvQ
	(envelope-from <linux-sctp+bounces-1221-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Thu, 28 May 2026 11:21:06 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B285EF7D1
	for <lists+linux-sctp@lfdr.de>; Thu, 28 May 2026 11:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0E36302978F
	for <lists+linux-sctp@lfdr.de>; Thu, 28 May 2026 09:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352D239D6D2;
	Thu, 28 May 2026 09:07:35 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD9C38B125;
	Thu, 28 May 2026 09:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779959255; cv=none; b=Nc2B+9e4Oghx+s1PZbLEHzRcfOuirpAW+8eK4TFFpx9IoOYNwevdeO2Dx+Dw/lWuCX6Fzd9XNBEKYhmj5j4qSCxvUB6FVnaUuYifYOiDGPI/nmN2hGMQs108+dRx0fWakLmGUBsHCVQBQ/h6WQrxAJW2knyI+FjKydY6tSj3Q34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779959255; c=relaxed/simple;
	bh=i41N7TeqKHJ2+blz1BQJ6LHsPGzSsBIjrgOCVyCtnf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U5YsqZAjM8PjX+Ghn+JJAL8JhSGQGsa2js0Z2mRarYTyTH+8pdOsJyaf5mTTc3SCgdtFB6nyP1KY35yu4vbCZ6iSd/+JTFOcvjpYiSOZFXBqlPltSEEGcUr6gEh7YrR7zZYwYDNx42kl7NMEhUy925FIa1pC+KB4jMLha4kZAlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from [IPV6:fdfe:dcba:9876::1] (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowAD3E77OBRhqXkQ4AA--.40405S2;
	Thu, 28 May 2026 17:07:26 +0800 (CST)
Message-ID: <bb40b01b-5ef8-4d88-bbd8-d1017edab006@lzu.edu.cn>
Date: Thu, 28 May 2026 17:07:26 +0800
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] sctp: stream: clear out_curr when freeing stream
 data
To: linux-sctp@vger.kernel.org, netdev@vger.kernel.org
Cc: marcelo.leitner@gmail.com, lucien.xin@gmail.com, davem@davemloft.net,
 yuantan098@gmail.com, yifanwucs@gmail.com, tomapufckgml@gmail.com,
 zcliangcn@gmail.com, bird@lzu.edu.cn, xuyq21@lenovo.com
References: <cover.1779640196.git.xuyq21@lenovo.com>
 <cd2b851530e741d4878ee7db59cba895d70e672a.1779640196.git.xuyq21@lenovo.com>
Content-Language: en-US
From: Ren Wei <n05ec@lzu.edu.cn>
In-Reply-To: <cd2b851530e741d4878ee7db59cba895d70e672a.1779640196.git.xuyq21@lenovo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:ygmowAD3E77OBRhqXkQ4AA--.40405S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw4fXF1DJF45WF4rWryrCrg_yoW8AFyDpF
	ZxKw4ftFZrJFyxGrn7Aa4FqFyrCw4kJ3y2krn0k3WDZr45Jr1FqFn2grWkXrykGr4j9rW2
	yFn093s3Kw4UAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9mb7Iv0xC_Cr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
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
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07U_HUDUUUUU=
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQABCWoX+s4A2gABsb
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,lzu.edu.cn,lenovo.com];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-1221-lists,linux-sctp=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[lzu.edu.cn];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,linux-sctp@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: F1B285EF7D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/28/26 15:51, Ren Wei wrote:
> From: Yuqi Xu <xuyq21@lenovo.com>
> 
> out_curr caches the current outbound stream and points into the
> stream->out storage. Once the stream tables are torn down, that
> pointer is no longer valid and must not survive the teardown.
> 
> sctp_stream_update() frees the old stream tables before installing
> the new ones. If out_curr still points into the old outbound table,
> later dequeue paths can continue from stale scheduler state instead
> of falling back to the normal queue walk.
> 
> Clear out_curr in sctp_stream_free(), which owns the lifetime of the
> stream storage and covers every teardown caller.
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

Sorry for the duplicate posting. I accidentally sent this patch series
twice.

Please ignore the extra copy. Apologies for the noise.

Best regards,
Ren Wei


