Return-Path: <linux-sctp+bounces-1217-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yC9QEt5nF2oZEAgAu9opvQ
	(envelope-from <linux-sctp+bounces-1217-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Wed, 27 May 2026 23:53:34 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9D55EA7BF
	for <lists+linux-sctp@lfdr.de>; Wed, 27 May 2026 23:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7F2A230582D7
	for <lists+linux-sctp@lfdr.de>; Wed, 27 May 2026 21:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D8B3A6B9A;
	Wed, 27 May 2026 21:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lo2C/cBA"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044AB362130
	for <linux-sctp@vger.kernel.org>; Wed, 27 May 2026 21:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779918807; cv=pass; b=fg9m8pi7zLD/gtgyjYe3lM2urkE3ryx5B6PEFUtu9yRQGSevUQqJm8/FTw3KT2tVUePnO9psc8OTti+2h2rGr/U174RimxfX44068IBJr+pEFBlvKflMvm1h05ScRG0nc2TYc+V6eptSR+4XlZTLYJyEvSvLbYItQeUMKve6ucs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779918807; c=relaxed/simple;
	bh=obIePSmQ9StIZWujUqwDhIiigBKuprK6vbC2wRCvt28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eV6dGnsUftJLsXfiBPShtMrRp/B7CmjFHGJE9+Zx9fSuFj7TexakxnPPTl8//lXocVI3fTNnKb4JMNUnvDYQmBpjqy+gGfD97TfpJEWy0ZSkooDUmwMJ4ge8PvgrfBBWQq3CMIGXDId+G5FPCIb46vw9zKSVAh1mqH+WTCpyXOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lo2C/cBA; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-83d5bbef760so5121656b3a.1
        for <linux-sctp@vger.kernel.org>; Wed, 27 May 2026 14:53:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779918804; cv=none;
        d=google.com; s=arc-20240605;
        b=ASYL22suzGdMYhTtL7DSH3SxVZ4Q8Agpa37PGNRE2nrfMrwQh9Hn0mfrHTaFOOHs5Z
         rQGnVETFv/qDBCF8t+4fcRbPQyxqkP4KR+07VZw3pqwiXM7rwj8QLNrqk3ERRQZe1Tky
         IGjhlnr0YKMJaJu9hiwG9pnykjGawYG3yLYOU7WxIGtJoAE4c5H3539cez79HzHCVUpV
         461DvbWRwbpg5i0xA3TntsLG3KEYBuEG9KDJVnJi/jcxlDUBaekBz+3CmJZtwYE2SPTM
         KVMYWpqr9Pgt4ddgxMOiFAXuP2v5EtXGh9MguRrIZgUFtLnghgs77k48HappJ+XZcUlz
         rz6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GyNTDCBxdTK2oUXaYmqMZNuIzrPaxBPOLpkTXgfkXYc=;
        fh=uWyes7byO7sC7WOkDawhM3RQlvHvXt6tmTu+xlmHXss=;
        b=eJh+GeSoueuZRjbgLT5GTzVM6Hr3SzhAyv8OPVtPef2qPbeTpaoC81V9EsHzzMYDwN
         5OM5gXNsVP9ylkHRf8wemLVhycZswRM3UM5zp9PzrMo3OiHsAceBluMnrFHb2oPI2awR
         6+eZ0iGlbOjeyXFI4C4g0Kjxpjl3K5vqfLQ1JuZS3UtLvv9e4Tqm28bmvfxHL1ys8NNz
         aG0BtaWB0j+TajIsp2dkBMfgsWUv53KBJ2uCoXZTBsysuLAS456ksXW5ZDYzlAiDcI1g
         3uCg6WXmPzuaPhZp2PGxpIKEkR6V4mlDeuwh+IhbF9zB3F+w8isNkhuuupIZoa9ZKgti
         Y+yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779918804; x=1780523604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GyNTDCBxdTK2oUXaYmqMZNuIzrPaxBPOLpkTXgfkXYc=;
        b=Lo2C/cBAY1Mr1ZkN6eNmj/xZcsbyrgB76K3BlhmpSDkGjnOhZb0TxLncPKamUeyHC0
         gAyqKIkoysRvPeeP0G5X7sb6py41u71aXFWAbAO6vPr+V8LInb4gWFiREHyOb+OF8bvv
         N3SSi9QDSEU2f0itWkn61jOB77wPVR2mYesSP+d9H5Y0xmgohegNaU/Ep4FPLo4J4xXl
         GaafplarmdJOKG/1yjZ854FZt+4JW7gYo8yVLt4v2O/nuiu0KAwqIQSaNzjGi41oEb6v
         BjP49rnhkNW0m2UEpQ1nz/GjwpDWFlhjomwd234EUJrQ/cFnVMImGYQGsPu1pNMjF9+2
         IwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779918804; x=1780523604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GyNTDCBxdTK2oUXaYmqMZNuIzrPaxBPOLpkTXgfkXYc=;
        b=VHM6GwBS0lprqo1RHBQR9a60DqSkDM4qorj+rq6YHiS6KmTybpE8co4NN+PrGoAM61
         /ZXeq2V50EG3y39axr6Ik6SpGqwuz8dRFusAH7fmZfFCaDF51PLVyRall3hLVKDZ2aW0
         XaBbveae7WEIQUkaOOUuGcJtEdj0++f7TiGAt9Pnq4NNKEsDA5xSbxrLT3TCqmF0NWhz
         Vl3VT+yLNvItoahxSkCX2UKWLKRxtoQjN9lSBJEDHnKR/KbHptV4vLQudyjG2zCrs1+U
         Ut5aifXBQg+HF7bSCsvCmRH5GL79LwBUpU0LdNp4hBZKbXJXIEi+HLfBptfzFIIYnoZz
         HcMw==
X-Gm-Message-State: AOJu0YzW1CG6LcUfKZHCUsayBb7qIUgrys0cy+JqTp6N2X3c8fysZd8c
	wewjZKUr/YX3pOqeFw6b7OXz6VL/71tZ0int7jhank450AsVmdz6q0WvLCWuWSIukS3vyLD5dGA
	PHKkDTxS7PlEoR4n2bwzfc8ufGBg47kc=
X-Gm-Gg: Acq92OHqANOyIwcPsPAGqxVcBhw61mSkEn9cByYubq+rnetxy6KDvogfnG9KysQGniX
	uXgKyMy+x1RCUztNNxRIxHYA1o5i1r1KaP4LYEWVlaMXOreJWAgtxOinE09fLrW6O/6XtOU69Gw
	KILVa0JzU86pbuiNzCJoqeExtogmuvp64fNMQqqlst0u1NhV9w0mww5mzv9Wz/i9R0AEwTE/zul
	QbNXNV/WmzWf+z+lwtD81ayo6TFT5qp0aOf1+ZYdqOyE8YlbdCGAxqH4U3hu0ISy6p9TXweeiUz
	E6LiuE8B5WSTjIfbCBmqAvlm9wZvJzsmxbElhGC3mtwMFGWIPh7/Uke9CX808uxb8JE4SVXdW43
	cG2Na3/UjsYTHBvymSrPSd2XemHhMPnrwoX1pY0yUyINj/YIshg==
X-Received: by 2002:a05:6a00:849:b0:83e:f228:b112 with SMTP id
 d2e1a72fcca58-8415f3799aemr23326619b3a.34.1779918804159; Wed, 27 May 2026
 14:53:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1779635498.git.xuyq21@lenovo.com> <8049cf6a7d4e62a002397cf289c09ff373b19f7f.1779635498.git.xuyq21@lenovo.com>
In-Reply-To: <8049cf6a7d4e62a002397cf289c09ff373b19f7f.1779635498.git.xuyq21@lenovo.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 27 May 2026 17:53:12 -0400
X-Gm-Features: AVHnY4JMhqox-4neS28F9_X8UrzmgVKL_rnpOYljH4l3vwJK6pLIZcZmI2V-q-s
Message-ID: <CADvbK_eOSCO6760yYbSVyn7eCo5a78jMjMomocbR+z4Nqcd=6g@mail.gmail.com>
Subject: Re: [PATCH net 1/1] sctp: stream: rebind out_curr when updating streams
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	marcelo.leitner@gmail.com, davem@davemloft.net, yuantan098@gmail.com, 
	yifanwucs@gmail.com, tomapufckgml@gmail.com, zcliangcn@gmail.com, 
	bird@lzu.edu.cn, xuyq21@lenovo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1217-lists,linux-sctp=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,lzu.edu.cn,lenovo.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid,lenovo.com:email]
X-Rspamd-Queue-Id: DE9D55EA7BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 1:28=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrote:
>
> From: Yuqi Xu <xuyq21@lenovo.com>
>
> sctp_stream_update() replaces the outbound stream table while
> out_curr may still point to the current stream selected for an
> unfinished fragmented message.
>
> Remember the current stream id before freeing the old table and
> rebind out_curr after the new table is installed. If that stream
> no longer exists, clear the cached pointer instead.
>
> This keeps the scheduler cursor valid across stream table
> replacement without losing the current stream when it still
> survives the update.
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
>  net/sctp/stream.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/net/sctp/stream.c b/net/sctp/stream.c
> index c2247793c88b..fcb6c688f61d 100644
> --- a/net/sctp/stream.c
> +++ b/net/sctp/stream.c
> @@ -208,6 +208,16 @@ void sctp_stream_clear(struct sctp_stream *stream)
>  void sctp_stream_update(struct sctp_stream *stream, struct sctp_stream *=
new)
>  {
>         const struct sctp_sched_ops *sched =3D sctp_sched_ops_from_stream=
(stream);
> +       __u16 sid =3D SCTP_MAX_STREAM;
> +
> +       /* Preserve the current stream if its sid survives the table swap=
. */
> +       if (stream->out_curr) {
> +               for (sid =3D 0; sid < stream->outcnt; sid++)
> +                       if (SCTP_SO(stream, sid) =3D=3D stream->out_curr)
> +                               break;
> +               if (sid =3D=3D stream->outcnt)
> +                       sid =3D SCTP_MAX_STREAM;
> +       }
>
>         sched->unsched_all(stream);
>         sctp_stream_outq_migrate(stream, new, new->outcnt);
> @@ -217,6 +227,7 @@ void sctp_stream_update(struct sctp_stream *stream, s=
truct sctp_stream *new)
>         stream->in  =3D new->in;
>         stream->outcnt =3D new->outcnt;
>         stream->incnt  =3D new->incnt;
> +       stream->out_curr =3D sid < stream->outcnt ? SCTP_SO(stream, sid) =
: NULL;
>
>         sched->sched_all(stream);
>
Thanks for the report and patch.

sctp_stream_update() is only called in COOKIE_WAIT state, where
stream->out_curr is expected to be NULL, since no user data should have
been sent at or before this state unless the state transitioned backward.

However, there is a corner case in sctp_sf_do_5_2_6_stale(): when a Stale
Cookie ERROR is received, the association may move from COOKIE_ECHOED back
to COOKIE_WAIT. If data was already bundled with COOKIE-ECHO to send out,
this issue can be triggered.

Updating stream->out_curr here is not a proper fix here, as any transmitted
data would also remain in the retransmit queue.

Since this restarts the handshake, negotiated parameters may change, so
previously queued/sent data should be dropped.

So you can fix it by purging the outqueue in sctp_sf_do_5_2_6_stale() like:

diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index 8e89a870780c..9b23c11cbb9e 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -2598,11 +2598,7 @@ static enum sctp_disposition sctp_sf_do_5_2_6_stale(
         */
        sctp_add_cmd_sf(commands, SCTP_CMD_DEL_NON_PRIMARY, SCTP_NULL());

-       /* If we've sent any data bundled with COOKIE-ECHO we will need to
-        * resend
-        */
-       sctp_add_cmd_sf(commands, SCTP_CMD_T1_RETRAN,
-                       SCTP_TRANSPORT(asoc->peer.primary_path));
+       sctp_add_cmd_sf(commands, SCTP_CMD_PURGE_OUTQUEUE, SCTP_NULL());

        /* Cast away the const modifier, as we want to just
         * rerun it through as a sideffect.

The userspace would rely on SCTP_SEND_FAILED_EVENT to get notified.

Thanks.

