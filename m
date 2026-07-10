Return-Path: <linux-sctp+bounces-1320-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jM5SD1MRUWru+wIAu9opvQ
	(envelope-from <linux-sctp+bounces-1320-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Fri, 10 Jul 2026 17:35:47 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9957A73C519
	for <lists+linux-sctp@lfdr.de>; Fri, 10 Jul 2026 17:35:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=a8oD3tTa;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1320-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1320-lists+linux-sctp=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0ED8F3014C60
	for <lists+linux-sctp@lfdr.de>; Fri, 10 Jul 2026 15:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A54542CB0F;
	Fri, 10 Jul 2026 15:35:02 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7DF41736F
	for <linux-sctp@vger.kernel.org>; Fri, 10 Jul 2026 15:35:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783697702; cv=pass; b=ELHjNUKppKTVnKCj4jIhphB5hBwI0zN3Bc4Yf0PH4QU/gSUTZ8g/ezs3+Bx6Y8Axnl3vY2a1OdMg4k8airLUO9eJZXZ9W6U650zo4R45fUCenWpKPl9zvdofZGrZLcJwJPItHCcECwlVcw7ySy4aBc9vOkprwgIDlUI3L+oErBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783697702; c=relaxed/simple;
	bh=lKiZCBDDETUpGjxrmw9i9h3I0UoRrm7LD3o1s0rYbt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uj+V3WvdlEoATsNG6WzMaw7iRm4uOqKWEgdpFE0V3Pq8VwtRKQIMLxLSA+c25W/2zuNmEDZGgL9UEpbm/9UZ4EQhComEXb8iuw7IHE3KCfQzVTnCV/+5wyu0EV6WVHgX55sGznXFvYJW2q+TcpdYZW8jd5LaFboJyhncYGDxiWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8oD3tTa; arc=pass smtp.client-ip=209.85.210.175
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-845c92bc464so963996b3a.2
        for <linux-sctp@vger.kernel.org>; Fri, 10 Jul 2026 08:35:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783697700; cv=none;
        d=google.com; s=arc-20260327;
        b=nGUFDE0PcGcWmS/45eDuobpDFmC0bb2A2OA9On/8Oo575cGS8C89TK5hRUVCMUMk91
         BzQ6RdAbnoV1+sDSF7IabEZ4lUV5gBpJKrRSgFnu1XuD6gf/+iDheU8lXdcNGHQA3yuH
         5mkqJ3VWeIxmvS7tgX3/cQ6j3Gj+69CffA7IhHGin+chaOYUaoyU6mlIRNTlbwXfWHLy
         EE2Sro4jzBy+eYfNToQjjT+8UlVmlGr4BAmVGXEEWE2rrLxO85CaEhkzomZ7mv2eKsYj
         TIQEbUNMBEDVSxpzhTfJ9E5pRhgvtcmBy6fbLg5mSoDEj7N6TKBFv1gkrk2rdJ61lXk4
         u7HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lfqsy36kEg0n71UWqhMQmPaJ8MvzIuF/nMwbLEQv8KY=;
        fh=LLXWY07d+MQ1JMG38CzbVwjO8AqElG7Hv7aNt5tLtSY=;
        b=cYY4jLJ7YW7kCY/GGyRnDGErQUKPnmRMowCg/WPCoEyYVpYgnO2KECs7+rQiQYWflR
         31qO/YKzDkSdJ3PLrcbdBwOwfkyKSqwS+QqCTMK3RtCPcjDiEK0qKe3FWFR9BrAc/eES
         DBF4ogas+h8C06DOQVznhxNXfgrjixImJ8KitLL5pqjqV8BnNJpSO+538KsbbjlqVGFC
         5AjKDKMXQkTWBeQO9eQoLpU93cpAMFpQlb6o2oXOGFJTHkiSic0PI8SGvGodoa1RPBwa
         6qv1eF2kLY27Ny5YRVTxOIyNwmib3O5h2e3wPaOAh/ZkZpHuc67/1jbm6xmydMvW4DqH
         ujXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783697700; x=1784302500; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lfqsy36kEg0n71UWqhMQmPaJ8MvzIuF/nMwbLEQv8KY=;
        b=a8oD3tTaRKi4aTkrkspHVR/eFsSuVsDdmHub1TGYRTsaYEwWotKCTegELXvcOQwKL9
         fqIxCSwukN0Jk6qnHF4ctBJZt212taAkwtLCjSm3ecBYmxtw7hSpi/QDkuMsa/EOTPJE
         NnlnodRyG9SdC0uHp0GoreDvv4DBEXUZrbf+jHL2cSitDkS3Wn1dCHYWIUzkBZNDm+qj
         FYcizqVrmUwZWuJ+OkofQxypC+hahkOe4J+xAuetPU2TESH+ukDSMKR9p92xSuZU3tAG
         uxWfFx1E8OBT6xL/NAR5eg4rUa9+g1NpdGX8qLuUdsaCA1mmS7fVXKbbNeAGuapXiy7w
         v8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783697700; x=1784302500;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lfqsy36kEg0n71UWqhMQmPaJ8MvzIuF/nMwbLEQv8KY=;
        b=g/gOwCrEpjK92WYW3wu+rwFgtRe9L6FXEpT6ay3F8kLc4bSCURyyW+Xab5uxWL7/8g
         RkLZEX5P70fpOihkk4olO8bMGyAzGzuK08HqvNfupZriRWo/dKqqCa8B/UMOFzeyYAT1
         4fq/nVCLm2yEhU4WlTSqDEmZd62RZy5Whr5fpeTcwiW/PlnHGlitbHGYhEc3CigsdKhf
         3lr0YpHBR9v+SgCCaJcSGdqYhOrgErUWFns7zEyaWZOo1RKg++wnmAZmhibGMvxoLSnL
         gHXJ0s4ZfrqWwMAL82yQxfIvBo6nXTs0Lb+Nlb0RKhXBireLikXvtExZ8/35lUugdDGp
         +3ww==
X-Forwarded-Encrypted: i=1; AHgh+Rpn77rlPu3JK5Z/VrVq1pL+jIplDN+zSxAG4it8i6BKIKbELRK13Kh3NIaDZnA8btW3FtCOyAimsoA1@vger.kernel.org
X-Gm-Message-State: AOJu0YzlopLtNlyHgN27A+XBzIepW5Ze9yO2XwTwLZktvygz0ouEWUev
	7lqNS0NryWriLVSON6zQWr3hQunBDRdlW0Tgl3Qv1qHWxxk+fAKeW1WZT3IGsqKg70aBZE2BW0d
	3C0JGbHzyJ0qRlp+Gi0+ld89JWkzy6Uc=
X-Gm-Gg: AfdE7cn8Nn8BhtcFLUIDGlAO0rqW2ML+TXttyNVl5mIRh65BHJcT/DCJB6kePbHa8TK
	6b2UllmMDyDqrMmJyV84fDNi46Y9wUTblWKUmQK3R0tHO5E7fKYvLjPM1kkr9EQo8bPSoI0xTwd
	LakQYxMWL67QloDTl1z4Z5xU/OV4kYHdLwcTht2D5LaSw2ipX6a96Ny+S4PGzhGzgPqhHd+AWMc
	a/ivhBwkEzXmUoWpglVtSIK326U60NZ8EJLxHtbIHh3XfDAE/EzHX2icUJmXtZ+qvfcgJx8jZSe
	lk0tChc2rgwH87x4g1mlOQN1vLe22yjVZtXNzeSGDmvpSfZ14CfQ5HUYE5OSKRcZvGLk8A0+pQM
	RjUrm6y4=
X-Received: by 2002:a05:6a00:94ed:b0:848:42a7:1854 with SMTP id
 d2e1a72fcca58-84843437157mr10598707b3a.39.1783697700484; Fri, 10 Jul 2026
 08:35:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710010718.20318-1-blbllhy@gmail.com> <20260710092559.40f37700@pumpkin>
In-Reply-To: <20260710092559.40f37700@pumpkin>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 10 Jul 2026 11:34:47 -0400
X-Gm-Features: AUfX_mzmhSy_FTOCbC6jONxJg6y1CF6hzGKuPLQMVmanaYtYZMtGKwJe5pMpPNs
Message-ID: <CADvbK_cKB+t2LJOs-VQKP9svHURckHpuYdwwZB9an0+FYuomxg@mail.gmail.com>
Subject: Re: [PATCH net v2] sctp: validate stream count in sctp_process_strreset_inreq()
To: David Laight <david.laight.linux@gmail.com>
Cc: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>, marcelo.leitner@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com, 
	tgopinath@linux.microsoft.com, kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:blbllhy@gmail.com,m:marcelo.leitner@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,m:davidlaightlinux@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-1320-lists,linux-sctp=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,microsoft.com,linux.microsoft.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9957A73C519

On Fri, Jul 10, 2026 at 4:26=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Thu,  9 Jul 2026 21:07:18 -0400
> "Cen Zhang (Microsoft)" <blbllhy@gmail.com> wrote:
>
> > When processing a RESET_IN_REQUEST from a peer,
> > sctp_process_strreset_inreq() derives the stream count from the
> > parameter length but does not check whether the resulting
> > RESET_OUT_REQUEST would exceed SCTP_MAX_CHUNK_LEN.
> >
> > The OUT request header (sctp_strreset_outreq, 16 bytes) is 8 bytes
> > larger than the IN request header (sctp_strreset_inreq, 8 bytes).
> > Generally, the IP payload is bounded to 65535 bytes, so the stream
> > list cannot be large enough to trigger the overflow. However, on
> > interfaces with MTU > 65535 (e.g., loopback with IPv6 jumbograms), a
> > stream list that fits within the incoming IN parameter can cause a
> > __u16 overflow in sctp_make_strreset_req() when computing the OUT
> > request size, leading to an undersized skb allocation and a kernel
> > BUG:
> >
> >   net/core/skbuff.c:207         skb_panic
> >   net/core/skbuff.c:2625        skb_put
> >   net/sctp/sm_make_chunk.c:1535 sctp_addto_chunk
> >   net/sctp/sm_make_chunk.c:3695 sctp_make_strreset_req
> >   net/sctp/stream.c:655         sctp_process_strreset_inreq
> >
> > The local setsockopt path validates the generated reset request size.
> > However, for an incoming-only reset, it accounts for the smaller IN
> > request even though the peer must generate an OUT request with the same
> > stream list. Such a request cannot be completed successfully by the
> > peer.
> >
> > Reject peer IN requests whose corresponding OUT request would exceed
> > SCTP_MAX_CHUNK_LEN. Also tighten the local check so it does not send an
> > IN request that would require an oversized OUT request from the peer.
> >
> > Fixes: 7f9d68ac944e ("sctp: implement sender-side procedures for SSN Re=
set Request Parameter")
> > Reported-by: AutonomousCodeSecurity@microsoft.com
> > Closes: https://lore.kernel.org/all/20260707203215.2752-1-blbllhy@gmail=
.com/
> > Suggested-by: Xin Long <lucien.xin@gmail.com>
> > Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
> > ---
> > v2: Add the OUT request length check to the send path, as suggested by =
Xin Long.
> >
> >  net/sctp/stream.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/sctp/stream.c b/net/sctp/stream.c
> > index 5c2fdedea088..34ffe6c945a4 100644
> > --- a/net/sctp/stream.c
> > +++ b/net/sctp/stream.c
> > @@ -308,7 +308,8 @@ int sctp_send_reset_streams(struct sctp_association=
 *asoc,
> >                                       goto out;
> >
> >                       param_len +=3D str_nums * sizeof(__u16) +
> > -                                  sizeof(struct sctp_strreset_inreq);
> > +                                  (out ? sizeof(struct sctp_strreset_i=
nreq)
> > +                                       : sizeof(struct sctp_strreset_o=
utreq));
>
> Does it really make any sense to have a connection with the 32k streams
> that would be needed in order to send a maximal length request?
> (Or more likely a user requesting the same streams be reset multiple time=
s.)
> So an initial check that str_nums < SOME_CONSTANT_JUST_BELOW_32K would do=
.
>
Yes, that would be a simpler fix.

However, 32K is not a limit defined by the RFC. While 32K streams may seem
excessive in practice, we cannot say that such a configuration is invalid.
If an application legitimately needs more than that, it would be difficult
to argue that it is not using SCTP correctly.

> Looking at the code I'm sure the kmalloc() shouldn't be done in the
> 'str_nums =3D=3D 0' case either.
> In fact it is probably worth doing the kmalloc() earlier to avoid two
> scans of the array.
> I even wonder if it should be possible to allocate the chunk without fill=
ing
> in the data and then put the values in afterwards (freeing the chunk if t=
here
> is an error).
>
> Then there is the code that reverts the state to OPEN if sctp_send_reconf=
()
> fails - nothing check that is the original state.
>
That would be another issue that we can address separately.
It would be great if you could follow up on this one. :-)

>         David
>
>
> >               }
> >
> >               if (param_len > SCTP_MAX_CHUNK_LEN -
> > @@ -639,6 +640,9 @@ struct sctp_chunk *sctp_process_strreset_inreq(
> >
> >       nums =3D (ntohs(param.p->length) - sizeof(*inreq)) / sizeof(__u16=
);
> >       str_p =3D inreq->list_of_streams;
> > +     if (nums * sizeof(__u16) + sizeof(struct sctp_strreset_outreq) >
> > +         SCTP_MAX_CHUNK_LEN - sizeof(struct sctp_reconf_chunk))
> > +             goto out;
> >       for (i =3D 0; i < nums; i++) {
> >               if (ntohs(str_p[i]) >=3D stream->outcnt) {
> >                       result =3D SCTP_STRRESET_ERR_WRONG_SSN;
>

Acked-by: Xin Long <lucien.xin@gmail.com>

Thanks.

