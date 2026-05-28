Return-Path: <linux-sctp+bounces-1223-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MysIrlHGGr2iQgAu9opvQ
	(envelope-from <linux-sctp+bounces-1223-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Thu, 28 May 2026 15:48:41 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 173675F2FB3
	for <lists+linux-sctp@lfdr.de>; Thu, 28 May 2026 15:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A97D2318241D
	for <lists+linux-sctp@lfdr.de>; Thu, 28 May 2026 13:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90553EFFDF;
	Thu, 28 May 2026 13:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o2M6/K0w"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540233ABDA8
	for <linux-sctp@vger.kernel.org>; Thu, 28 May 2026 13:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779975725; cv=pass; b=pikwDjKz3FZ0H4xTlR4fUXjjWwr5xDvyMfISRLBtjfV2lGa3oDlgUKEX9HucIikvIrC38rhJIwQzkfErlJCvjKm+t85+tWSxX75z4lzvBREAZFMleC9zeTO66cs/UDqotaz/rgr2O49XUYID8VHiGt+JXVPkNHJLeen8zJFg/wI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779975725; c=relaxed/simple;
	bh=ech48L+YtHB5+v14LJc84EaiJ02dhLWh5PJBNI19S2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mET7Eue6yxN9p8oT5Lo6Jp3Y2CZX0HQnMm/vH7ErrVXB+1YUTGa0z2DkWilAtoeQOMZnqe0Kpzo+IXGEKGGF2jsfsmwfqtLvdE7ToPOEyMRp4PKQ9Es8AeDCtWO27UrZsAq9EZODAV+zsikrrCHzmi4GGW/XjcudliXo/N82iKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o2M6/K0w; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c85625854d3so292118a12.2
        for <linux-sctp@vger.kernel.org>; Thu, 28 May 2026 06:42:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779975724; cv=none;
        d=google.com; s=arc-20240605;
        b=J5t0zczmO3FSMIPZzdwht8NizQrz/bheLnHzsVfaHXUA2A1xCIm4nErdFlsHswqRH+
         v0s8QVGCArnK3bfCbc9DjCGgJNdImp9509k9dSbxkWwzT4pGxKRxEU+iFepigiNAeIZT
         /j/KSE/JkOZoe6/7hkLorhpKgOgU0AgSP28tLFTMYFyfJdulJdSnMQ+L1OZbLkPBMwYF
         wxwsgNZweoMhgKM38ss0yMdlsc0f1EPIjBLaQWpdPjRytBNoAalgAVj6HK5eqXaGG58J
         3zlILX4M5lM1gKR7XvKfkNLCBQGd+CEn1Ye8oLEa+eErw9uhTyv/ps18VPPyCA8QXwI2
         CA/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8R3ZCxKpbNcmdcqfZFVwiYeS0XVSXQ7IH6lz3U+ld0A=;
        fh=SeFvtY41niyecZpfu0KhpXnfRUwG0hsnRRj06c7SjJ8=;
        b=fsdeMMZi5hhIIDKp0X9RmJ4NZnvcKetpRQe3p5Np/5+yUN8awaKT0YHwc0QRNt5Lqr
         VbSEVI5LEuRrPS4EXaXwstqI6BXfWmGzHRFpsq40jztXgcdr3EPBnpUd9IhnkVxqJ+eW
         uJvrCLtJvVmCgO4k0QBq+UzCK6BVlxk6ucRPK6NbvnQsYN3fQ7u0u0R3AU8evu13m9dW
         SH1IylALRGP6P8QZwx7UFZ2eYeZetVcGsMyOEfGjthommYtsufoZ8d8iCA2k6prw4+TG
         j7b2yEThDW/D0/hAjafHzNe9RlTHp5gnVK3HvUnImeAluI0KvCjUjvQjhSTtxhnDQtz4
         lwdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779975724; x=1780580524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8R3ZCxKpbNcmdcqfZFVwiYeS0XVSXQ7IH6lz3U+ld0A=;
        b=o2M6/K0wNGzWFIc8YpZwTVH162ouWX6u/9u3SFTEfwMTa7LbqwLTDLSENYvRMcnZsM
         89zAOzaCOFHsMZzlZRbv6biLCsT6pSrlskrdGaRP7y45eEgRJvjWr5tPFIzuueNsRMMC
         TZiMnXahzyDZ2Pq7yN7YA/d15tpPQVHm2NAboV3RZ9PcbymM6ddmxNIN7+70GxiRDcaT
         y/05QScHrQgyDl5wLq9tyKokexql6zXYD5WtzTZ1C9E1Fk4RX0UDGeFFswQUKV3jyzWV
         jVo3B9YtP6PbDcZepCRCVjKq73LhGNThxe/CDPuG/ZSRtvXGE7IiIW62KM9+biDTxhr5
         380w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779975724; x=1780580524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8R3ZCxKpbNcmdcqfZFVwiYeS0XVSXQ7IH6lz3U+ld0A=;
        b=sg1oairXtbSuwtnZALTJpVUpf/SYhZazjIrIIBLL1qZwoarK8zU91ymbZiSOmzViE4
         EnpSx3xpSZNm+XTuXZxC7Dq0rvHDDhKEr+liQgLTwq0T6lrwKakaUMVp0JJ/qMVxy81y
         x/bn+cx6GPSlpN69lIEiqRwfl1EaZbktX2NqrwTsVu944z4Kl3CTWMMPwtkQhedFaU5f
         O+DFpe0WTBWe8qAn/+9ucv3N3+MqczVE6xa3fSu3R/7WXo9pvO1yuW52xNNz8pdGpFwb
         A8GkB4OAs01Zme2y2YMGA95ZlRXWzlbkQPL1g0H5ip3AAdxTviJkgfdwsIksOiXD/jE/
         VZSw==
X-Forwarded-Encrypted: i=1; AFNElJ/A6HWjHIG7VrX1b5bkKPmh4S6VGa3sxfkWbJtHa0ZG1Ox6AkUiLG+yS8gm9GjWquwY0oKzBspp2qOg@vger.kernel.org
X-Gm-Message-State: AOJu0YyWF7xCBuox2d8ao3voIlzSYoCDndWeFjHE1n8BQ6DsAMHH4c3p
	CCX5nQj+wYQjJMvPiayUZwuQEo8r6nuevDn1if1K1ICDRqUrv6aRkGS/kDNEvxabFrkJ29VLbJU
	B8NdXJdJGHpc89d+1+Zuv8nBH5RtZtPQ=
X-Gm-Gg: Acq92OGF6EPjodqWcXCB9v96uCMY5RfPfzSaeRB1J58Rbz8KpL1v66c4+WkODb7jEKI
	A/gkWiWK4sa0m6cPygF/0frlkG8ZGmwqUF5OFj0Q3ntMdh37IvTTx8NTLipZcdJ/JPH3HR1MCu+
	BuAuvjdiG1yGsFn7SCsviDEWyWyp4Y0JX0+knpPkY0X4ixpX5sDKpyciNiPkLCUAg5NTb4AbA9A
	ui/CkAjZQhgE+htsKTm//INpPW6eFjWjmHvyGq1QFUlB+XT1MDtVz8g8IPstWEGV2unRxXw6WHD
	7gx8ooHLD4Txl0Is2+rfOiCr8VkoSYw9yz/wxpwv0Mj84Lgc0Ej+UMDgnjt+KOavJFqC6kBZlf1
	VId/lyZhEDKGTUxktRaMUtbsPMrOb6yRJOiZBgubJyzZOXcGQoGpKddufD+rOqA==
X-Received: by 2002:a05:6a21:1bc6:b0:398:6ea8:21d2 with SMTP id
 adf61e73a8af0-3b328d4c0bamr28789330637.19.1779975723578; Thu, 28 May 2026
 06:42:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527032411.60959-1-kipreyyy@gmail.com>
In-Reply-To: <20260527032411.60959-1-kipreyyy@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 28 May 2026 09:41:51 -0400
X-Gm-Features: AVHnY4JDED5tqgKLQimcclOHI34tUsvK1WY-SZ9YwxPKLW0EPwRo2z7dpR7qoIk
Message-ID: <CADvbK_fDMF8sAPcskb_WsL3d+4gSunviSZebsFS-XxQG2HUUCA@mail.gmail.com>
Subject: Re: [PATCH net] sctp: fix race between sctp_wait_for_connect and peeloff
To: Zhenghang Xiao <kipreyyy@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, linux-sctp@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1223-lists,linux-sctp=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-sctp];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: 173675F2FB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 11:24=E2=80=AFPM Zhenghang Xiao <kipreyyy@gmail.com=
> wrote:
>
> sctp_wait_for_connect() drops and re-acquires the socket lock while
> waiting for the association to reach ESTABLISHED state. During this
> window, another thread can peeloff the association to a new socket via
> getsockopt(SCTP_SOCKOPT_PEELOFF), changing asoc->base.sk. After
> re-acquiring the old socket lock, sctp_wait_for_connect() returns
> success without noticing the migration =E2=80=94 the caller then accesses
> the association under the wrong lock in sctp_datamsg_from_user().
>
> Add the same sk !=3D asoc->base.sk check that sctp_wait_for_sndbuf()
> already has, returning an error if the association was migrated while
> we slept.
>
> Fixes: 668c9beb9020 ("sctp: implement assign_number for sctp_stream_inter=
leave")
> Signed-off-by: Zhenghang Xiao <kipreyyy@gmail.com>
> ---
>  net/sctp/socket.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index 1d2568bb6bc2..66e12fb0c646 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -9403,6 +9403,8 @@ static int sctp_wait_for_connect(struct sctp_associ=
ation *asoc, long *timeo_p)
>                 release_sock(sk);
>                 current_timeo =3D schedule_timeout(current_timeo);
>                 lock_sock(sk);
> +               if (sk !=3D asoc->base.sk)
> +                       goto do_error;
>
>                 *timeo_p =3D current_timeo;
>         }
> --
> 2.50.1 (Apple Git-155)
>

Acked-by: Xin Long <lucien.xin@gmail.com>


Note that the pre-existing issue reported in
https://sashiko.dev/#/patchset/20260527032411.60959-1-kipreyyy%40gmail.com

I don't think it exists, as the state of any of ep->asocs should not be in
CLOSED state. sctp_wait_for_connect() can only be triggered by the path
with sctp_sendmsg_new_asoc() called, not the SCTP_SENDALL path.

The reason why it doesn't return the error from 2nd sctp_wait_for_connect()
is: there's already user data enqueued at the time, we should return the
sent length to userspace even if the asoc has been peeled off.

Thanks.

